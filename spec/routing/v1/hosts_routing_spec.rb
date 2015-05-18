require 'rails_helper'

RSpec.describe V1::HostsController, type: :routing do

  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/v1/hosts').to route_to(
        'v1/hosts#index',
        format: :json
      )
    end

    it 'routes #new to #show with ID "new"' do
      expect(get: '/v1/hosts/new').to route_to(
        'v1/hosts#show',
        id: 'new',
        format: :json
      )
    end

    it 'routes to #show' do
      expect(get: '/v1/hosts/1').to route_to(
        'v1/hosts#show',
        id: '1',
        format: :json
      )
    end

    it 'routes to #edit' do
      expect(get: '/v1/hosts/1/edit').not_to be_routable
    end

    it 'does not route to #create' do
      expect(post: '/v1/hosts').to_not be_routable
    end

    it 'routes to #update' do
      expect(patch: '/v1/hosts/1').to route_to(
        'v1/hosts#update',
        id: '1',
        format: :json
      )
    end

    it 'does not route to #destroy' do
      expect(delete: '/v1/hosts/1').to_not be_routable
    end
  end

end
