# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alerts/index', type: :view do
  let(:yesterday) { 1.day.before(Time.current) }
  let(:last_hour) { 1.hour.before(Time.current) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'alerts' }
    allow(controller).to receive(:action_name) { 'index' }
    server = FactoryBot.create(:server, name: 'xyzmirth')
    channel = FactoryBot.create(:channel, server: server, name: 'other_channel')
    cs = FactoryBot.create(:channel_statistic, server: server, 
                                               channel: channel,
                                               name: 'Some Statistics')

    assign(:alerts, [
             Alert.create!(
               server_id: server.id,
               channel_id: channel.id,
               channel_statistic_id: cs.id,
               type: 'alert',
               message: 'MyText',
               created_at: yesterday
             ),
             Alert.create!(
               server_id: server.id,
               channel_id: channel.id,
               channel_statistic_id: cs.id,
               type: 'recovery',
               message: 'MyText',
               created_at: last_hour
             )
           ])
  end

  it 'renders a list of alerts' do
    render
    assert_select 'tr>td', text: 'xyzmirth'.to_s, count: 2
    assert_select 'tr>td', text: 'other_channel'.to_s, count: 2
    assert_select 'tr>td', text: 'Some Statistics'.to_s, count: 2
    assert_select 'tr>td', text: 'alert'.to_s, count: 1
    assert_select 'tr>td', text: 'recovery'.to_s, count: 1
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: yesterday.localtime.to_formatted_s(:db).to_s, count: 1
    assert_select 'tr>td', text: last_hour.localtime.to_formatted_s(:db).to_s, count: 1
  end
end
