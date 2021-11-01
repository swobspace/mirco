require 'rails_helper'

RSpec.describe "notes/new", type: :view do
  before(:each) do
    assign(:note, Note.new(
      server: nil,
      channel: nil,
      user: nil,
      type: ""
    ))
  end

  it "renders new note form" do
    render

    assert_select "form[action=?][method=?]", notes_path, "post" do

      assert_select "input[name=?]", "note[server_id]"

      assert_select "input[name=?]", "note[channel_id]"

      assert_select "input[name=?]", "note[user_id]"

      assert_select "input[name=?]", "note[type]"
    end
  end
end
