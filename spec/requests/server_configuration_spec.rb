require 'rails_helper'

RSpec.describe "ServerConfigurations", type: :request do
  let!(:server) { FactoryBot.create(:server) }

  before(:each) do
    login_admin
  end

  let(:valid_attributes) do
    FactoryBot.attributes_for(:server_configuration, server_id: server.id)
  end

  let(:invalid_attributes) do
    { server_id: nil }
  end

  describe "GET /index" do
    it "returns http success" do
      config = ServerConfiguration.create! valid_attributes
      get server_server_configurations_url(server)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      config = ServerConfiguration.create! valid_attributes
      get server_server_configuration_url(server, config)
      expect(response).to have_http_status(:success)
      expect(response.headers['Content-Disposition'])
        .to match("attachment; filename=\"#{config.to_s.gsub(':', '%3A')}.xml\"")
    end
  end

end
