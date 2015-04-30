require 'rails_helper'

RSpec.describe V1::HostsController, type: :controller do
  let(:user)  { FactoryGirl.create :user }
  let(:host)  { FactoryGirl.create :host }
  let(:token) { double :acceptable? => true }

  before do
    allow(controller).to receive(:doorkeeper_token) {token}
    allow(controller).to receive(:current_user) {user}
  end

  before :each do
    # set required env
    ENV['aws_access_key_id']     = 'KEY ID'
    ENV['aws_secret_access_key'] = 'ACCESS KEY'
    ENV['region']                = 'eu-central-1'

    Fog.mock!
  end

  context '#index' do
    it 'is successful' do
      get :index
      expect(response).to be_successful
    end

    it 'uses ActiveModel::ArraySerializer' do
      get :index
      expect(response).to render_serializer 'ActiveModel::ArraySerializer'
    end

    it 'does an EC2 import' do
      expect(Ec2::Importer).to receive(:run)
      get :index
    end
  end

  context '#show' do
    it 'is successful' do
      get :show, id: host.to_param
      expect(response).to be_successful
    end

    it 'uses V1::HostSerializer' do
      get :show, id: host.to_param
      expect(response).to render_serializer V1::HostSerializer
    end
  end

  context '#update' do
    context 'with valid attributes' do
      let(:attributes) {
        FactoryGirl.attributes_for :host, puppet_config: "classes:\n- admins"
      }

      it 'is successful' do
        patch :update, id: host.to_param, host: attributes
        expect(response).to be_successful
      end

      it 'changes the model' do
        expect {
          patch :update, id: host.to_param, host: attributes
        }.to change { host.reload.puppet_config }
      end

      it 'uses V1::HostSerializer' do
        patch :update, id: host.to_param, host: attributes
        expect(response).to render_serializer V1::HostSerializer
      end
    end

    context 'with invalid attributes' do
      let(:attributes) {
        FactoryGirl.attributes_for :host, puppet_config: 'Not YAML'
      }

      it 'fails' do
        patch :update, id: host.id, host: attributes
        expect(response).to be_unprocessable
      end

      it 'does not change the record' do
        expect {
          patch :update, id: host.to_param, host: attributes
        }.not_to change(host, :puppet_config)
      end

      it 'does not use V1::HostSerializer' do
        patch :update, id: host.to_param, host: attributes
        expect(response).not_to render_serializer V1::HostSerializer
      end
    end
  end
end
