require "rails_helper"

RSpec.describe V1::PuppetClassesController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/puppet_classes').to route_to(
        'v1/puppet_classes#index',
        format: :json
      )
    end

    it 'routes #new to #show with ID "new"' do
      expect(get: '/v1/puppet_classes/new').to route_to(
        'v1/puppet_classes#show',
        id: 'new',
        format: :json
      )
    end

    it 'routes to #show' do
      expect(get: '/v1/puppet_classes/1').to route_to(
        'v1/puppet_classes#show',
        id: '1',
        format: :json
      )
    end

    it 'routes to #edit' do
      expect(get: '/v1/puppet_classes/1/edit').not_to be_routable
    end

    it 'does not route to #create' do
      expect(post: '/v1/puppet_classes').to route_to(
        'v1/puppet_classes#create',
        format: :json
      )
    end

    it 'routes to #update' do
      expect(patch: '/v1/puppet_classes/1').to route_to(
        'v1/puppet_classes#update',
        id: '1',
        format: :json
      )
    end

    it 'does not route to #destroy' do
      expect(delete: '/v1/puppet_classes/1').to route_to(
        'v1/puppet_classes#destroy',
        id: '1',
        format: :json
      )
    end
  end

end
