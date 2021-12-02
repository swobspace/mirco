# frozen_string_literal: true

require 'rails_helper'

module Servers
  RSpec.describe ChannelsController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/servers/88/channels', server_id: '88').to route_to('servers/channels#index', server_id: '88')
      end

      it 'routes to #new' do
        expect(get: '/servers/88/channels/new', server_id: '88').not_to be_routable
      end

      it 'routes to #show' do
        expect(get: '/servers/88/channels/1', server_id: '88').not_to be_routable
      end

      it 'routes to #edit' do
        expect(get: '/servers/88/channels/1/edit', server_id: '88').not_to be_routable
      end

      it 'routes to #create' do
        expect(post: '/servers/88/channels', server_id: '88').not_to be_routable
      end

      it 'routes to #fetch_all' do
        expect(post: '/servers/88/channels/fetch_all',
               server_id: '88').to route_to('servers/channels#fetch_all', server_id: '88')
      end

      it 'routes to #update via PUT' do
        expect(put: '/servers/88/channels/1', server_id: '88').not_to be_routable
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/servers/88/channels/1', server_id: '88').not_to be_routable
      end

      it 'routes to #destroy' do
        expect(delete: '/servers/88/channels/1',
               server_id: '88').to route_to('servers/channels#destroy', id: '1', server_id: '88')
      end
    end
  end
end
