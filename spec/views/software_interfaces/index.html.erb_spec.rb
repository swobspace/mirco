require 'rails_helper'

RSpec.describe "software_interfaces/index", type: :view do
  before(:each) do
    assign(:software_interfaces, [
      SoftwareInterface.create!(
        software: nil,
        name: "Name",
        hostname: "Hostname",
        ipaddress: "",
        description: nil
      ),
      SoftwareInterface.create!(
        software: nil,
        name: "Name",
        hostname: "Hostname",
        ipaddress: "",
        description: nil
      )
    ])
  end

  it "renders a list of software_interfaces" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Hostname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
