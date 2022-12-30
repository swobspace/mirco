# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'home' }
    allow(controller).to receive(:action_name) { 'index' }
    current_user = FactoryBot.create(:user, sn: 'Mustermann', givenname: 'Max')
    allow(controller).to receive(:current_user) { current_user }
    allow(current_user).to receive(:is_admin?).and_return(true)


    assign(:queued_messages, FactoryBot.create_list(:channel_statistic, 2))
    assign(:servers, FactoryBot.create_list(:server, 2))
    assign(:problems, [])
  end

  it 'renders start page' do
    render
    expect(rendered).to match(/Queued Messages/)
  end
end
