# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/channels', type: :request do
  let!(:server) do
    FactoryBot.create(:server,
                      api_url: ENV['API_URL'],
                      api_user: ENV['API_USER'],
                      api_password: ENV['API_PASSWORD'],
                      api_verify_ssl: ENV['API_VERIFY_SSL'])
  end
  let(:valid_attributes) do
    FactoryBot.attributes_for(:channel, server_id: server.id)
  end

  before(:each) do
    login_admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Channel.create! valid_attributes
      get channels_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      channel = Channel.create! valid_attributes
      get channel_url(channel)
      expect(response).to be_successful
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested channel' do
      channel = Channel.create! valid_attributes
      expect do
        delete channel_url(channel)
      end.to change(Channel, :count).by(-1)
    end

    it 'redirects to the channels list' do
      channel = Channel.create! valid_attributes
      delete channel_url(channel)
      expect(response).to redirect_to(channels_path)
    end
  end
end
