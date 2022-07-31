require 'rails_helper'

RSpec.describe "software_connections/index", type: :view do
  let(:server) { FactoryBot.create(:server, name: 'XYZMIRTH') }
  let(:location) { FactoryBot.create(:location, lid: 'LLY') }
  let(:swif1) { FactoryBot.create(:interface_connector) }
  let(:swif2) { FactoryBot.create(:interface_connector) }
  let(:swif3) { FactoryBot.create(:interface_connector) }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_connection' }
    allow(controller).to receive(:action_name) { 'index' }
    allow(swif1).to receive(:to_s).and_return("SWIF1")
    allow(swif2).to receive(:to_s).and_return("SWIF2")
    allow(swif3).to receive(:to_s).and_return("SWIF3")

    assign(:software_connections, [
      SoftwareConnection.create!(
        server: server,
        location: location,
        source_connector: swif1,
        source_url: "Source Url",
        destination_connector: swif2,
        destination_url: "Destination Url",
        ignore: false,
        ignore_reason: "Ignore Reason",
        description: "Some TEXT"
      ),
      SoftwareConnection.create!(
        server: server,
        location: location,
        source_connector: swif1,
        source_url: "Source Url",
        destination_connector: swif3,
        destination_url: "Destination Url2",
        ignore: false,
        ignore_reason: "Ignore Reason",
        description: "Some TEXT"
      )
    ])
  end

  it "renders a list of software_connections" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("XYZMIRTH".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("LLY".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(swif1.sw_name.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(swif1.if_name.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("SWIF1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Source Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("SWIF2".to_s), count: 1
    assert_select cell_selector, text: Regexp.new(swif2.sw_name.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(swif2.if_name.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(swif3.sw_name.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(swif3.if_name.to_s), count: 1
    assert_select cell_selector, text: Regexp.new("SWIF3".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Destination Url".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ignore Reason".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Some TEXT".to_s), count: 2
  end
end
