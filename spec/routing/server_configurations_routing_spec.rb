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

  end
end
