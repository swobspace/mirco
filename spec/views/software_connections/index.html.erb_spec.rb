require 'rails_helper'

RSpec.describe "software_connections/index", type: :view do
  before(:each) do
    assign(:software_connections, [
      SoftwareConnection.create!(
        source_connector: nil,
        source_url: "Source Url",
        destination_connector: nil,
        destination_url: "Destination Url",
        ignore: false,
        ignore_reason: "Ignore Reason",
        description: nil
      ),
      SoftwareConnection.create!(
        source_connector: nil,
        source_url: "Source Url",
        destination_connector: nil,
        destination_url: "Destination Url",
        ignore: false,
        ignore_reason: "Ignore Reason",
        description: nil
      )
    ])
  end

  it "renders a list of software_connections" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Source Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Destination Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ignore Reason".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
