require 'rails_helper'

RSpec.describe "interface_connectors/index", type: :view do
  before(:each) do
    assign(:interface_connectors, [
      InterfaceConnector.create!(
        software_interface: nil,
        type: "Type",
        url: "Url",
        description: nil
      ),
      InterfaceConnector.create!(
        software_interface: nil,
        type: "Type",
        url: "Url",
        description: nil
      )
    ])
  end

  it "renders a list of interface_connectors" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Type".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
