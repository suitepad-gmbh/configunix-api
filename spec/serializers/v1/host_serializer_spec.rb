require 'rails_helper'

RSpec.describe V1::HostSerializer, type: :serializer do
  let(:resource) { FactoryGirl.create :host }

  it { should respond_to(:id) }
  it { should respond_to(:instance_id) }
  it { should respond_to(:dns_name) }
  it { should respond_to(:private_dns_name) }
  it { should respond_to(:public_ip_address) }
  it { should respond_to(:private_ip_address) }
  it { should respond_to(:puppet_config) }
  it { should respond_to(:created_at) }

end
