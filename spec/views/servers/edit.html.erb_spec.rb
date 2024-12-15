# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'servers/edit', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'servers' }
    allow(controller).to receive(:action_name) { 'edit' }

    @server = assign(:server, FactoryBot.create(:server))
  end

  it 'renders the edit server form' do
    render

    assert_select 'form[action=?][method=?]', server_path(@server), 'post' do
      assert_select 'input[name=?]', 'server[name]'
      assert_select 'input[name=?]', 'server[uid]'
      assert_select 'select[name=?]', 'server[location_id]', count: 0
      assert_select 'select[name=?]', 'server[host_id]'
      assert_select 'textarea[name=?]', 'server[description]'
      assert_select 'input[name=?]', 'server[api_url]'
      assert_select 'input[name=?]', 'server[api_user]'
      assert_select 'input[name=?]', 'server[api_password]'
      assert_select 'input[name=?]', 'server[api_user_has_full_access]'
      assert_select 'input[name=?]', 'server[api_verify_ssl]'
      assert_select 'input[name=?]', 'server[properties]', count: 0
      assert_select 'input[name=?]', 'server[manual_update]'
      assert_select 'input[name=?]', 'server[disabled]'
    end
  end
end
