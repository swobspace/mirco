require 'rails_helper'

RSpec.describe 'channels/index', type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channels' }
    allow(controller).to receive(:action_name) { 'index' }
    @server = FactoryBot.create(:server, name: 'xyzmirth')

    assign(:channels, [
             Channel.create!(
               server: @server,
               uid: '0d612b6b-c4ff-4e88-a34c-f1ca2ece6349',
               properties: { name: 'VeryFirstChannel' }
             ),
             Channel.create!(
               server: @server,
               uid: 'fa9c355f-d201-4431-b4af-92dccfd9224b',
               properties: { name: 'SecondChannel' }
             )
           ])
  end

  it 'renders a list of channels' do
    render
    assert_select 'tr>td', text: '0d612b6b-c4ff-4e88-a34c-f1ca2ece6349'.to_s, count: 1
    assert_select 'tr>td', text: 'fa9c355f-d201-4431-b4af-92dccfd9224b'.to_s, count: 1
    expect(rendered).to match('VeryFirstChannel')
    expect(rendered).to match('SecondChannel')
  end
end
