# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'channels/show', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channels' }
    allow(controller).to receive(:action_name) { 'index' }
    @server = FactoryBot.create(:server, name: 'xyzmirth')

    @channel = assign(:channel, Channel.create!(
                                  server: @server,
                                  uid: '7a44a44d-44fa-4f83-a381-cf078acf06cb',
                                  properties: { name: 'FirstChannel' },
                                  state: 'STARTED'
                                ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/xyzmirth/)
    expect(rendered).to match(/7a44a44d-44fa-4f83-a381-cf078acf06cb/)
    expect(rendered).to match(/enabled/)
    expect(rendered).to match(/STARTED/)
  end
end
