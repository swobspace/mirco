require 'rails_helper'

RSpec.describe "interface_connectors/index", type: :view do
  let(:software_interface) { FactoryBot.create(:software_interface, name: 'IM4HC') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'interface_connectors' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:interface_connectors, [
      InterfaceConnector.create!(
        software_interface: software_interface,
        name: 'ADT out',
        type: "TxConnector",
        url: "Url",
        description: 'some text'
      ),
      InterfaceConnector.create!(
        software_interface: software_interface,
        type: "RxConnector",
        name: 'BAR in',
        url: "Url",
        description: 'some text'
      )
    ])
  end

  it "renders a list of interface_connectors" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("IM4HC".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("ADT out".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("BAR in".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("TxConnector".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("RxConnector".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("some text".to_s), count: 2
  end
end
