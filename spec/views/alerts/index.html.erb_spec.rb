# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alerts/index', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'alerts' }
    allow(controller).to receive(:action_name) { 'index' }
    server = FactoryBot.create(:server, name: 'xyzmirth')
    channel = FactoryBot.create(:channel, server: server, name: 'other_channel')

    assign(:alerts, [
             Alert.create!(
               server_id: server.id,
               channel_id: channel.id,
               type: 'alert',
               message: 'MyText',
               created_at: 1.day.before(Time.current)
             ),
             Alert.create!(
               server_id: server.id,
               channel_id: channel.id,
               type: 'recovery',
               message: 'MyText',
               created_at: 1.hour.before(Time.current)
             )
           ])
  end

  it 'renders a list of alerts' do
    render
    assert_select 'tr>td', text: 'xyzmirth'.to_s, count: 2
    assert_select 'tr>td', text: 'other_channel'.to_s, count: 2
    assert_select 'tr>td', text: 'alert'.to_s, count: 1
    assert_select 'tr>td', text: 'recovery'.to_s, count: 1
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 1.day.before(Time.current).localtime.to_formatted_s(:db).to_s, count: 1
    assert_select 'tr>td', text: 1.hour.before(Time.current).localtime.to_formatted_s(:db).to_s, count: 1
  end
end
