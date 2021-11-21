require 'rails_helper'

module Servers
  RSpec.describe "notes/index", type: :view do
    let(:user) { FactoryBot.create(:user) }
    let!(:time) { Time.now }
    before(:each) do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      allow(controller).to receive(:current_ability) { @ability }
      allow(controller).to receive(:controller_name) { "notes" }
      allow(controller).to receive(:action_name) { "index" }
      @notable = FactoryBot.create(:server, name: "xyzmirth")

      @note = assign(:note, FactoryBot.create(:note, server_id: @notable.id))

      assign(:notes, [
        FactoryBot.create(:note,
          server: @notable,
          channel_id: nil,
          user: user,
          type: "note",
          message: "some text",
          created_at: time,
        ),
        FactoryBot.create(:note,
          server: @notable,
          channel_id: nil,
          user: user,
          type: "note",
          message: "some text",
          created_at: time,
        )
      ])
    end

    it "renders a list of notes" do
      render
      assert_select "tr>td", text: time.to_formatted_s(:db), count: 2
      assert_select "tr>td", text: nil.to_s, count: 4
      assert_select "tr>td", text: user.to_s, count: 2
      assert_select "tr>td", text: "note".to_s, count: 2
      assert_select "tr>td", text: "some text".to_s, count: 2
    end
  end
end
