# frozen_string_literal: true

require 'rails_helper'

module ChannelStatistics
  RSpec.describe NotesController, type: :routing do
    describe 'routing' do
      it 'routes to #index' do
        expect(get: '/channel_statistics/88/notes').to route_to('channel_statistics/notes#index', channel_statistic_id: '88')
      end

      it 'routes to #new' do
        expect(get: '/channel_statistics/88/notes/new').to route_to('channel_statistics/notes#new', channel_statistic_id: '88')
      end

      it 'routes to #show' do
        expect(get: '/channel_statistics/88/notes/1').to route_to('channel_statistics/notes#show', id: '1', channel_statistic_id: '88')
      end

      it 'routes to #edit' do
        expect(get: '/channel_statistics/88/notes/1/edit').to route_to('channel_statistics/notes#edit', id: '1', channel_statistic_id: '88')
      end

      it 'routes to #create' do
        expect(post: '/channel_statistics/88/notes').to route_to('channel_statistics/notes#create', channel_statistic_id: '88')
      end

      it 'routes to #update via PUT' do
        expect(put: '/channel_statistics/88/notes/1').to route_to('channel_statistics/notes#update', id: '1', channel_statistic_id: '88')
      end

      it 'routes to #update via PATCH' do
        expect(patch: '/channel_statistics/88/notes/1').to route_to('channel_statistics/notes#update', id: '1', channel_statistic_id: '88')
      end

      it 'routes to #destroy' do
        expect(delete: '/channel_statistics/88/notes/1').to route_to('channel_statistics/notes#destroy', id: '1', channel_statistic_id: '88')
      end
    end
  end
end
