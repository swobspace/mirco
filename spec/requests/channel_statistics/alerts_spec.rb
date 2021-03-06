# frozen_string_literal: true

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/alerts', type: :request do
  let(:server) { FactoryBot.create(:server, name: 'MyServer') }
  let(:channel) { FactoryBot.create(:channel, server: server, name: 'MyChannel') }
  let(:cs) { FactoryBot.create(:channel_statistic, server: server, 
                                                   channel: channel, 
                                                   name: 'MyStatistic') }

  let(:valid_attributes) do
    {
      server_id: server.id,
      channel_id: channel.id,
      channel_statistic_id: cs.id,
      type: 'alert',
      message: 'some special stuff'
    }
  end

  before(:each) do
    login_admin
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Alert.create! valid_attributes
      get channel_statistic_alerts_url(cs)
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      alert = Alert.create! valid_attributes
      get channel_statistic_alert_url(cs, alert)
      expect(response).to be_successful
    end
  end
end
