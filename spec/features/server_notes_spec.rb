require 'rails_helper'

RSpec.describe "Server/notes", type: :feature do
  fixtures 'wobauth/roles'

  let(:server) { FactoryBot.create(:server, name: "aaamirth") }

  describe "show server notes", js: true do
    it "switch to notes tab" do
      login_user(role: 'Manager')
      visit server_path(server, anchor: 'notes-tab')
      expect(page).to have_content("aaamirth")
      pending "bootstrap javascript needs more work"
      expect(find("h4.title")).to have_content("Notizen")
    end
  end

end
