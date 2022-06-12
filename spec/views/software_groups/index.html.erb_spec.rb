require 'rails_helper'

RSpec.describe "software_groups/index", type: :view do
  before(:each) do
    assign(:software_groups, [
      SoftwareGroup.create!(
        name: "Name",
        description: "Description"
      ),
      SoftwareGroup.create!(
        name: "Name",
        description: "Description"
      )
    ])
  end

  it "renders a list of software_groups" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
  end
end
