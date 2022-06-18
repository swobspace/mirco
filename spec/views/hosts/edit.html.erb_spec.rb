require 'rails_helper'

RSpec.describe "hosts/edit", type: :view do
  let(:location) { FactoryBot.create(:location) }
  let(:software_group) { FactoryBot.create(:software_group) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'hosts' }
    allow(controller).to receive(:action_name) { 'edit' }

    @host = assign(:host, Host.create!(
      location: location,
      software_group: software_group,
      name: "MyString",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders the edit host form" do
    render

    assert_select "form[action=?][method=?]", host_path(@host), "post" do
      assert_select "select[name=?]", "host[location_id]"
      assert_select "select[name=?]", "host[software_group_id]"
      assert_select "input[name=?]", "host[name]"
      assert_select "input[name=?]", "host[ipaddress]"
      assert_select "input[name=?]", "host[description]"
    end
  end
end
