require 'rails_helper'

RSpec.describe "ChannelCounters", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/channel_counters/index"
      expect(response).to have_http_status(:success)
    end
  end

end
