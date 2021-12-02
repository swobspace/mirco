# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/servers/88/notes').to route_to('servers/notes#index', server_id: '88')
    end

    it 'routes to #new' do
      expect(get: '/servers/88/notes/new').to route_to('servers/notes#new', server_id: '88')
    end

    it 'routes to #show' do
      expect(get: '/servers/88/notes/1').to route_to('servers/notes#show', id: '1', server_id: '88')
    end

    it 'routes to #edit' do
      expect(get: '/servers/88/notes/1/edit').to route_to('servers/notes#edit', id: '1', server_id: '88')
    end

    it 'routes to #create' do
      expect(post: '/servers/88/notes').to route_to('servers/notes#create', server_id: '88')
    end

    it 'routes to #update via PUT' do
      expect(put: '/servers/88/notes/1').to route_to('servers/notes#update', id: '1', server_id: '88')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/servers/88/notes/1').to route_to('servers/notes#update', id: '1', server_id: '88')
    end

    it 'routes to #destroy' do
      expect(delete: '/servers/88/notes/1').to route_to('servers/notes#destroy', id: '1', server_id: '88')
    end
  end
end
