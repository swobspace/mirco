require 'rails_helper'

RSpec.describe "notes/index", type: :view do
  before(:each) do
    assign(:notes, [
      Note.create!(
        server: nil,
        channel: nil,
        user: nil,
        type: "Type"
      ),
      Note.create!(
        server: nil,
        channel: nil,
        user: nil,
        type: "Type"
      )
    ])
  end

  it "renders a list of notes" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Type".to_s, count: 2
  end
end
