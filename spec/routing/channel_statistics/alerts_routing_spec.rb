# frozen_string_literal: true

require 'rails_helper'

module ChannelStatistics
  RSpec.describe AlertsController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/channel_statistics/88/alerts').to route_to('channel_statistics/alerts#index', channel_statistic_id: '88')
      end

      it 'routes to #new' do
        expect(get: '/channel_statistics/88/alerts/new').to route_to('channel_statistics/alerts#show', id: 'new', channel_statistic_id: '88')
      end

      it 'routes to #show' do
        expect(get: '/channel_statistics/88/alerts/1').to route_to('channel_statistics/alerts#show', id: '1', channel_statistic_id: '88')
      end

      it 'routes to #edit' do
        expect(get: '/channel_statistics/88/alerts/1/edit').not_to be_routable
      end

      it 'routes to #create' do
        expect(post: '/channel_statistics/88/alerts').not_to be_routable
      end

      it 'routes to #update via PUT' do
        expect(put: '/channel_statistics/88/alerts/1').not_to be_routable
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/channel_statistics/88/alerts/1').not_to be_routable
      end

      it 'routes to #destroy' do
        expect(delete: '/channel_statistics/88/alerts/1').not_to be_routable
      end
    end
  end
end
