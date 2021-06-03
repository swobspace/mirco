 require 'rails_helper'

RSpec.describe "/channels", type: :request do
  let!(:server) { FactoryBot.create(:server,
    api_url: ENV['API_URL'],
    api_user: ENV['API_USER'],
    api_password: ENV['API_PASSWORD'],
    api_verify_ssl: ENV['API_VERIFY_SSL']
  )}
  let(:valid_attributes) {
    FactoryBot.attributes_for(:channel, server_id: server.id)
  }

  before(:each) do
    login_admin
  end

  describe "GET /index" do
    it "renders a successful response" do
      Channel.create! valid_attributes
      get server_channels_url(server)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      channel = Channel.create! valid_attributes
      get server_channel_url(server, channel)
      expect(response).to be_successful
    end
  end

  describe "POST /fetch_all" do
    it "creates a new Channel" do
      expect {
        post fetch_all_server_channels_url(server)
      }.to change(Channel, :count).by_at_least(1)
    end

    it "redirects to servers/:id/channels" do
      post fetch_all_server_channels_url(server)
      expect(response).to redirect_to(server_url(server))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested channel" do
      channel = Channel.create! valid_attributes
      expect {
        delete server_channel_url(server, channel)
      }.to change(Channel, :count).by(-1)
    end

    it "redirects to the channels list" do
      channel = Channel.create! valid_attributes
      delete server_channel_url(server, channel)
      expect(response).to redirect_to(server_url(server))
    end
  end
end
