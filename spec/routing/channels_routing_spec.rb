# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChannelsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/channels').to route_to('channels#index')
    end

    it 'routes to #new' do
      pending 'needs more grips'
      expect(get: '/channels/new').not_to be_routable
    end

    it 'routes to #show' do
      expect(get: '/channels/1').to route_to('channels#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/channels/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: '/channels').not_to be_routable
    end

    it 'routes to #fetch_all' do
      expect(post: '/channels/fetch_all').not_to be_routable
    end

    it 'routes to #update via PUT' do
      expect(put: '/channels/1').not_to be_routable
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/channels/1').not_to be_routable
    end

    it 'routes to #destroy' do
      expect(delete: '/channels/1').to route_to('channels#destroy', id: '1')
    end

    it 'routes to #delete_outdated' do
      expect(delete: '/channels/delete_outdated').to route_to('channels#delete_outdated')
    end
  end
end
