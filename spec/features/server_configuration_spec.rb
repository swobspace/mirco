require 'rails_helper'

RSpec.describe "Server/server_configurations", type: :feature do
  let(:server) { FactoryBot.create(:server, name: "aaamirth") }

  describe "visit root path", js: true do

    before(:each) do
      allow(server).to receive(:up?).and_return(true)
      login_admin
      visit root_path
      execute_script("$.support.transition = false")
    end

    it "switch to server configuration tab" do
      visit server_path(server)
      expect(page).to have_content("aaamirth")
      click_button("Sicherungen der Konfiguration")
      expect(find("h4")).to have_content("Sicherungen der Konfiguration")
    end

    it "create a new backup of server configuration" do
      visit server_path(server)
      click_button("Sicherungen der Konfiguration")
      click_link("Mirth-Konfiguration sichern")
      within "#modal" do
        fill_in "Kommentar", with: "Sicher ist sicher"
        click_button("Sicherung der Konfiguration erstellen")
      end
      pending "needs more grips"
      expect(page).to have_content "Sicher ist sicher"
      expect(page).to have_content "Showing 1 to 1 of 1 entries"
      # save_and_open_screenshot()
    end

  end

end
