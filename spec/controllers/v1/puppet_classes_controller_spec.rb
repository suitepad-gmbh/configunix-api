require 'rails_helper'

RSpec.describe V1::PuppetClassesController, type: :controller do

  let(:user)  { FactoryGirl.create :user }
  let(:puppet_class)  { FactoryGirl.create :puppet_class }
  let(:token) { double :acceptable? => true }

  before do
    allow(controller).to receive(:doorkeeper_token) {token}
    allow(controller).to receive(:current_user) {user}
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
  end

  context '#show' do
    it 'is successful' do
      get :show, id: puppet_class.to_param
      expect(response).to be_successful
    end

    it 'uses V1::PuppetClassSerializer' do
      get :show, id: puppet_class.to_param
      expect(response).to render_serializer V1::PuppetClassSerializer
    end
  end

  context '#create' do
    context 'with valid attributes' do
      let(:attributes) {
        FactoryGirl.attributes_for :puppet_class
      }

      it 'is successful' do
        post :create, puppet_class: attributes
        expect(response).to be_successful
      end

      it 'creates a new record' do
        expect {
          post :create, puppet_class: attributes
        }.to change(PuppetClass, :count).by 1
      end

      it 'uses V1::PuppetClassSerializer' do
        post :create, puppet_class: attributes
        expect(response).to render_serializer V1::PuppetClassSerializer
      end
    end

    context 'with invalid attributes' do
      let(:attributes) {
        FactoryGirl.attributes_for :puppet_class, name: ''
      }

      it 'fails' do
        post :create, puppet_class: attributes
        expect(response).to be_unprocessable
      end

      it 'does not create a new record' do
        expect {
          post :create, puppet_class: attributes
        }.not_to change(PuppetClass, :count)
      end
    end
  end

  context '#update' do
    context 'with valid attributes' do
      let(:attributes) { { name: 'NewName' } }

      it 'is successful' do
        patch :update, id: puppet_class.to_param, puppet_class: attributes
        expect(response).to be_successful
      end

      it 'changes the model' do
        expect {
          patch :update, id: puppet_class.to_param, puppet_class: attributes
        }.to change { puppet_class.reload.name }
      end

      it 'uses V1::PuppetClassSerializer' do
        patch :update, id: puppet_class.to_param, puppet_class: attributes
        expect(response).to render_serializer V1::PuppetClassSerializer
      end
    end

    context 'with invalid attributes' do
      let(:attributes) { { name: '' } }

      it 'fails' do
        patch :update, id: puppet_class.id, puppet_class: attributes
        expect(response).to be_unprocessable
      end

      it 'does not change the record' do
        expect {
          patch :update, id: puppet_class.to_param, puppet_class: attributes
        }.not_to change(puppet_class, :name)
      end

      it 'does not use V1::PuppetClassSerializer' do
        patch :update, id: puppet_class.to_param, puppet_class: attributes
        expect(response).not_to render_serializer V1::PuppetClassSerializer
      end
    end
  end

  context '#destroy' do
    it 'is successful' do
      delete :destroy, id: puppet_class.to_param
      expect(response).to be_successful
    end

    it 'deletes the record' do
      puppet_class
      expect {
        delete :destroy, id: puppet_class.to_param
      }.to change(PuppetClass, :count).by -1
    end
  end
end

