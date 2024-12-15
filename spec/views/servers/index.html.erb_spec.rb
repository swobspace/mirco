# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'servers/index', type: :view do
  let(:location) { FactoryBot.create(:location, lid: 'LLX', name: 'Koka') }
  let(:host) do
    FactoryBot.create(:host, 
      name: 'BND03x', 
      ipaddress: '4.5.6.7', 
      location: location
    )
  end
  let(:time_now) { Time.current }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'servers' }
    allow(controller).to receive(:action_name) { 'index' }

    current_user = FactoryBot.create(:user, sn: 'Mustermann', givenname: 'Max')
    allow(controller).to receive(:current_user) { current_user }
    allow(current_user).to receive(:is_admin?).and_return(true)

    assign(:servers, [
             Server.create!(
               name: 'MyServer1',
               manual_update: true,
               uid: '0abac8b3-c096-485c-914f-ee8199d55db1',
               host_id: host.id,
               description: 'MyText',
               api_url: 'Api Url',
               api_user: 'Api User',
               api_password: 'MyText',
               api_user_has_full_access: false,
               properties: '',
               last_check: time_now,
               last_check_ok: time_now
             ),
             Server.create!(
               name: 'MyServer2',
               manual_update: true,
               uid: '9568b611-63b1-4870-8ee2-c309c16376ae',
               host_id: host.id,
               description: 'MyText',
               api_url: 'Api Url',
               api_user: 'Api User',
               api_password: 'MyText',
               api_user_has_full_access: false,
               properties: '',
               last_check: time_now,
               last_check_ok: time_now
             )
           ])
  end

  it 'renders a list of servers' do
    render
    assert_select 'tr>td', text: 'MyServer1'.to_s, count: 1
    assert_select 'tr>td', text: 'MyServer2'.to_s, count: 1
    assert_select 'tr>td', text: '9568b611-63b1-4870-8ee2-c309c16376ae'.to_s, count: 1
    assert_select 'tr>td', text: '0abac8b3-c096-485c-914f-ee8199d55db1'.to_s, count: 1
    assert_select 'tr>td', text: 'LLX: Koka'.to_s, count: 2
    assert_select 'tr>td', text: 'BND03x (4.5.6.7)'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Api Url'.to_s, count: 2
    assert_select 'tr>td', text: 'Api User'.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 4
    assert_select 'tr>td', text: ('✅ ' + time_now.to_s), count: 4
  end
end
