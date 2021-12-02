require 'rails_helper'

module Servers
  RSpec.describe ChannelStatisticsController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/servers/99/channel_statistics').to route_to('servers/channel_statistics#index', server_id: '99')
      end

      it 'routes to #show' do
        expect(get: '/servers/99/channel_statistics/1').to route_to('servers/channel_statistics#show', id: '1',
                                                                                                       server_id: '99')
      end

      it 'routes to #fetch_all' do
        expect(post: '/servers/99/channel_statistics/fetch_all').to route_to('servers/channel_statistics#fetch_all',
                                                                             server_id: '99')
      end
    end
  end
end
