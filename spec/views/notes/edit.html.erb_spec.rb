require 'rails_helper'

RSpec.describe "notes/edit", type: :view do
  before(:each) do
    @note = assign(:note, Note.create!(
      server: nil,
      channel: nil,
      user: nil,
      type: ""
    ))
  end

  it "renders the edit note form" do
    render

    assert_select "form[action=?][method=?]", note_path(@note), "post" do

      assert_select "input[name=?]", "note[server_id]"

      assert_select "input[name=?]", "note[channel_id]"

      assert_select "input[name=?]", "note[user_id]"

      assert_select "input[name=?]", "note[type]"
    end
  end
end
