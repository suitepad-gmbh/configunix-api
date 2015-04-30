require 'rails_helper'

RSpec.describe Ec2::Importer, type: :model do
  before :each do
    # set required env
    ENV['aws_access_key_id']     = 'KEY ID'
    ENV['aws_secret_access_key'] = 'ACCESS KEY'
    ENV['region']                = 'eu-central-1'

    # mock Fog requests
    Fog.mock!

    # Reset class instance variables
    Ec2::Importer.instance_variable_set '@_connection', nil
  end

  describe '#connection' do
    it 'creates a connection using the environment variables set' do
      expect(Fog::Compute).to receive(:new).with(
        provider: 'AWS',
        aws_access_key_id: 'KEY ID',
        aws_secret_access_key: 'ACCESS KEY',
        region: 'eu-central-1'
      )
      Ec2::Importer.send :connection
    end
  end

  describe '#servers' do
    it 'requests servers' do
      connection = Ec2::Importer.send :connection
      expect(connection).to receive(:servers)
      Ec2::Importer.send :servers
    end

    it 'returns an array' do
      expect(Ec2::Importer.send :servers).to be_an Array
    end
  end

  describe '#run' do
    let(:host) { FactoryGirl.create :host }
    let(:remote_host) {
      attributes = FactoryGirl.attributes_for(:host,
                                              created_at: 2.hours.ago,
                                              id: 'instance-id'
      )
      OpenStruct.new attributes
    }

    it 'requests servers' do
      expect(Ec2::Importer).to receive(:servers).and_return([], [])
      Ec2::Importer.run
    end

    it 'creates new hosts in the database' do
      expect(Ec2::Importer).to receive(:servers).and_return [remote_host], [remote_host]
      expect {
        Ec2::Importer.run
      }.to change(Host, :count).by 1
    end

    it 'is not creating a host twice' do
      remote_host.id = host.instance_id
      expect(Ec2::Importer).to receive(:servers).and_return [remote_host], [remote_host]
      expect {
        Ec2::Importer.run
      }.not_to change(Host, :count)
    end

    it 'updates the existing record' do
      remote_host.id = host.instance_id
      remote_host.dns_name = 'example.com'
      expect(Ec2::Importer).to receive(:servers).and_return [remote_host], [remote_host]
      expect {
        Ec2::Importer.run
      }.to change { host.reload.dns_name }.to 'example.com'
    end

    it 'deletes terminated instances' do
      deleted_host = FactoryGirl.create :host
      remote_host = FactoryGirl.create :host
      expect(Ec2::Importer).to receive(:servers).and_return [remote_host], [remote_host]
      Ec2::Importer.run

      expect {
        Host.find deleted_host.id
      }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
