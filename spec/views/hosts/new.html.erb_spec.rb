require 'rails_helper'

RSpec.describe "hosts/new", type: :view do
  let(:location) { FactoryBot.create(:location) }
  let(:software_group) { FactoryBot.create(:software_group) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'hosts' }
    allow(controller).to receive(:action_name) { 'new' }

    assign(:host, Host.new(
      location: location,
      software_group: software_group,
      name: "MyString",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders new host form" do
    render

    assert_select "form[action=?][method=?]", hosts_path, "post" do
      assert_select "select[name=?]", "host[location_id]"
      assert_select "select[name=?]", "host[software_group_id]"
      assert_select "input[name=?]", "host[name]"
      assert_select "input[name=?]", "host[ipaddress]"
      assert_select "input[name=?]", "host[description]"
    end
  end
end
