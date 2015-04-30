module SerializerExampleGroup
  extend ActiveSupport::Concern

  included do
    subject { described_class.new(resource) }
  end

  RSpec.configure do |config|
    config.include self, type: :serializer
  end
end
