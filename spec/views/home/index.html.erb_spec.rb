require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'home' }
    allow(controller).to receive(:action_name) { 'index' }

    @queued_messages = FactoryBot.create_list(:channel_statistic, 2)
    @servers = FactoryBot.create_list(:server, 2)
  end

  it 'renders start page' do
    render
    expect(rendered).to match(/Queued Messages/)
  end
end
