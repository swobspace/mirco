require 'rails_helper'

RSpec.describe "Server/alerts", type: :feature do
  let(:server) { FactoryBot.create(:server, name: "aaamirth") }

  describe "show server alerts", js: true do
    it "switch to alerts tab" do
      login_user(role: 'Manager')
      visit server_path(server, anchor: 'alerts-tab')
      expect(page).to have_content("aaamirth")
      click_button("Alarme")
      expect(find("h4")).to have_content("Alarme")
    end
  end

end
