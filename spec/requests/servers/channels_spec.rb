# frozen_string_literal: true

require 'rails_helper'

module Servers
  RSpec.describe 'Channels', type: :request do
    let!(:server) do
      FactoryBot.create(:server,
                        api_url: ENV['API_URL'],
                        api_user: ENV['API_USER'],
                        api_password: ENV['API_PASSWORD'],
                        api_verify_ssl: ENV['API_VERIFY_SSL'],
                        last_channel_update: Time.current)
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
        get server_channels_url(server)
        expect(response).to be_successful
        expect(assigns(:channels).count).to eq(1)
      end
    end

    describe 'GET /index' do
      let!(:obsolete) do 
        FactoryBot.create(:channel, 
          server_id: server.id,
          updated_at: 1.week.before(Date.current)
        )
      end
      it 'renders a successful response' do
        get server_channels_url(server, obsolete: "true")
        expect(response).to be_successful
        expect(assigns(:channels).count).to eq(1)
      end
    end


    describe 'POST /fetch_all' do
      it 'creates a new Channel' do
        expect do
          post fetch_all_server_channels_url(server)
        end.to change(Channel, :count).by_at_least(1)
      end

      it 'redirects to servers/:id/channels' do
        post fetch_all_server_channels_url(server)
        expect(response).to redirect_to(server_url(server))
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested channel' do
        channel = Channel.create! valid_attributes
        expect do
          delete server_channel_url(server, channel)
        end.to change(Channel, :count).by(-1)
      end

      it 'redirects to the channels list' do
        channel = Channel.create! valid_attributes
        delete server_channel_url(server, channel)
        expect(response).to redirect_to(server_url(server, anchor: 'channels-tab'))
      end

      it 'turbo_stream gets :200' do
        channel = Channel.create! valid_attributes
        delete server_channel_url(server, channel, format: :turbo_stream)
        expect(response.body).to match(/turbo-stream action="remove"/)
      end
    end
  end
end
