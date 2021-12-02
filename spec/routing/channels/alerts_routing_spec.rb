require 'rails_helper'

RSpec.describe Channels::AlertsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/channels/88/alerts').to route_to('channels/alerts#index', channel_id: '88')
    end

    it 'routes to #new' do
      expect(get: '/channels/88/alerts/new').to route_to('channels/alerts#show', id: 'new', channel_id: '88')
    end

    it 'routes to #show' do
      expect(get: '/channels/88/alerts/1').to route_to('channels/alerts#show', id: '1', channel_id: '88')
    end

    it 'routes to #edit' do
      expect(get: '/channels/88/alerts/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: '/channels/88/alerts').not_to be_routable
    end

    it 'routes to #update via PUT' do
      expect(put: '/channels/88/alerts/1').not_to be_routable
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/channels/88/alerts/1').not_to be_routable
    end

    it 'routes to #destroy' do
      expect(delete: '/channels/88/alerts/1').not_to be_routable
    end
  end
end
