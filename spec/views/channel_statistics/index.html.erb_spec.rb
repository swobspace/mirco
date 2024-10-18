# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'channel_statistics/index', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistics' }
    allow(controller).to receive(:action_name) { 'index' }
    @server = FactoryBot.create(:server, :with_uid, name: 'xyzmirth', manual_update: true)
    channel1 = FactoryBot.create(:channel, server: @server)
    channel2 = FactoryBot.create(:channel, server: @server)
    travel_to Time.now do
      ChannelStatistic.create!(
        server: @server,
        channel: channel1,
        server_uid: @server.uid,
        channel_uid: channel1.uid,
        name: 'FRITZ',
        state: 'STOPPED',
        status_type: 'DESTINATION',
        meta_data_id: 2,
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6,
        last_condition_change: 1.day.before(Time.current)
      )
      ChannelStatistic.create!(
        server: @server,
        channel: channel2,
        server_uid: @server.uid,
        channel_uid: channel2.uid,
        name: 'HORST',
        state: 'STARTED',
        status_type: 'DESTINATION',
        meta_data_id: 2,
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6,
        last_condition_change: 1.day.before(Time.current)
      )
    end
    assign(:channel_statistics, ChannelStatistic.all)
    allow_any_instance_of(ChannelStatistic).to receive(:condition).and_return(2)
  end

  it 'renders a list of channel_statistics' do
    render
    assert_select 'tr>td', text: @server.to_s, count: 0
    assert_select 'tr>td', text: 'FRITZ', count: 1
    assert_select 'tr>td', text: 'HORST', count: 1
    assert_select 'tr>td', text: 'STOPPED', count: 1
    assert_select 'tr>td', text: 'STARTED', count: 1
    assert_select 'tr>td', text: 'DESTINATION', count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
    assert_select 'tr>td', text: 5.to_s, count: 2
    assert_select 'tr>td', text: 6.to_s, count: 2
    assert_select 'tr>td', text: 'CRITICAL'.to_s, count: 2
    assert_select 'tr>td', text: 1.day.before(Time.current).to_fs(:local), count: 2
  end
end
