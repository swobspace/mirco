require 'rails_helper'

RSpec.describe "interface_connectors/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'interface_connectors' }
    allow(controller).to receive(:action_name) { 'edit' }

    @interface_connector = assign(:interface_connector, FactoryBot.build(:interface_connector))
  end

  it "renders new interface_connector form" do
    render

    assert_select "form[action=?][method=?]", interface_connectors_path, "post" do
      assert_select "select[name=?]", "interface_connector[software_interface_id]"
      assert_select "input[name=?]", "interface_connector[name]"
      assert_select "select[name=?]", "interface_connector[type]"
      assert_select "input[name=?]", "interface_connector[url]"
      assert_select "input[name=?]", "interface_connector[description]"
    end
  end
end
