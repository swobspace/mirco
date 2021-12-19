require 'rails_helper'

RSpec.describe "ServerConfigurations", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/server_configuration/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/server_configuration/show"
      expect(response).to have_http_status(:success)
    end
  end

end
