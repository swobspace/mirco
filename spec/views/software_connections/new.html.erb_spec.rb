require 'rails_helper'

RSpec.describe "software_connections/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_connection' }
    allow(controller).to receive(:action_name) { 'new' }

    @software_connection = assign(:software_connection, FactoryBot.build(:software_connection))
  end

  it "renders new software_connection form" do
    render

    assert_select "form[action=?][method=?]", software_connections_path, "post" do

      assert_select "select[name=?]", "software_connection[location_id]"
      assert_select "select[name=?]", "software_connection[source_connector_id]"
      assert_select "input[name=?]", "software_connection[source_url]"
      assert_select "select[name=?]", "software_connection[destination_connector_id]"
      assert_select "input[name=?]", "software_connection[destination_url]"
      assert_select "input[name=?]", "software_connection[ignore]"
      assert_select "input[name=?]", "software_connection[ignore_reason]"
      assert_select "input[name=?]", "software_connection[description]"
    end
  end
end
