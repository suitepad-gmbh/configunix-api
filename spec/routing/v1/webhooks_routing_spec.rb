require 'rails_helper'

RSpec.describe V1::WebhooksController, type: :routing do

  describe 'routing' do
    it 'routes /github to #github' do
      expect(post: '/v1/webhooks/github').to route_to(
        'v1/webhooks#github',
        format: :json
      )
    end
  end

end
