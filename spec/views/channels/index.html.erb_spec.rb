require 'rails_helper'

RSpec.describe "channels/index", type: :view do
  before(:each) do
    assign(:channels, [
      Channel.create!(
        server: nil,
        uid: "Uid",
        properties: ""
      ),
      Channel.create!(
        server: nil,
        uid: "Uid",
        properties: ""
      )
    ])
  end

  it "renders a list of channels" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Uid".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
