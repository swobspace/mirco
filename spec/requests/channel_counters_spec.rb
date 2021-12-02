# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ChannelCounters', type: :request do
  before(:each) do
    login_admin
  end

  describe 'GET /index' do
    it 'returns http success' do
      get '/channel_counters'
      expect(response).to have_http_status(:success)
    end
  end
end
