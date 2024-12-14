# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SearchesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/search').to route_to('searches#index')
    end
  end
end
