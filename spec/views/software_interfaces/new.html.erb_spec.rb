require 'rails_helper'

RSpec.describe "software_interfaces/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_interface' }
    allow(controller).to receive(:action_name) { 'new' }

    @software_interface = assign(:software_interface, FactoryBot.build(:software_interface))
  end

  it "renders new software_interface form" do
    render

    assert_select "form[action=?][method=?]", software_interfaces_path, "post" do

      assert_select "select[name=?]", "software_interface[software_id]"
      assert_select "input[name=?]", "software_interface[name]"
      assert_select "input[name=?]", "software_interface[hostname]"
      assert_select "input[name=?]", "software_interface[ipaddress]"
      assert_select "input[name=?]", "software_interface[description]"
    end
  end
end
