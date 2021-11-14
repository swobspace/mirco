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
      get channels_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      channel = Channel.create! valid_attributes
      get channel_url(channel)
      expect(response).to be_successful
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested channel" do
      channel = Channel.create! valid_attributes
      expect {
        delete channel_url(channel)
      }.to change(Channel, :count).by(-1)
    end

    it "redirects to the channels list" do
      channel = Channel.create! valid_attributes
      delete channel_url(channel)
      expect(response).to redirect_to(server_url(server))
    end
  end
end
