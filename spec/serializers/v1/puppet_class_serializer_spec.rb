require 'rails_helper'

RSpec.describe V1::PuppetClassSerializer, type: :serializer do
  let(:resource) { FactoryGirl.create :puppet_class }

  it { should respond_to(:id) }
  it { should respond_to(:name) }

end
