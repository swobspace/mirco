# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServerConfigurationsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/servers/88/server_configurations').to route_to('server_configurations#index', server_id: '88')
    end

    it 'routes to #show' do
      expect(get: '/servers/88/server_configurations/1').to route_to('server_configurations#show', id: '1', server_id: '88')
    end

   it 'routes to #new' do
      expect(get: '/servers/88/server_configurations/new').to route_to('server_configurations#new', server_id: '88')
    end

    it 'routes to #create' do
      expect(post: '/servers/88/server_configurations').to route_to('server_configurations#create', server_id: '88')
    end

   it 'routes to #destroy' do
      expect(delete: '/servers/88/server_configurations/1').to route_to('server_configurations#destroy', id: '1', server_id: '88')
    end

  end
end
