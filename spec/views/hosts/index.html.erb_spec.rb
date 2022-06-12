require 'rails_helper'

RSpec.describe "hosts/index", type: :view do
  before(:each) do
    assign(:hosts, [
      Host.create!(
        location: nil,
        software_group: nil,
        name: "Name",
        ipaddress: "",
        description: nil
      ),
      Host.create!(
        location: nil,
        software_group: nil,
        name: "Name",
        ipaddress: "",
        description: nil
      )
    ])
  end

  it "renders a list of hosts" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
