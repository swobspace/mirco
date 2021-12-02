# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/channel_statistics', type: :request do
  let!(:server) do
    FactoryBot.create(:server,
                      uid: '35f92757-b5a2-47a5-8485-bbba40988481a')
  end
  let!(:channel) do
    FactoryBot.create(:channel,
                      uid: '8efa687c-90d8-40ef-bbb0-ad92816d080c')
  end
  let(:valid_attributes) do
    FactoryBot.attributes_for(:channel, server_id: server.id)
  end

  before(:each) do
    login_admin
  end

  let(:valid_attributes) do
    FactoryBot.attributes_for(:channel_statistic,
                              server_id: server.id, server_uid: server.uid,
                              channel_id: channel.id, channel_uid: channel.uid)
  end

  let(:invalid_attributes) do
    { channel_uid: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      ChannelStatistic.create! valid_attributes
      get channel_statistics_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      channel_statistic = ChannelStatistic.create! valid_attributes
      get channel_statistic_url(channel_statistic)
      expect(response).to be_successful
    end
  end
end
