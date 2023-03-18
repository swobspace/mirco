require 'rails_helper'

RSpec.describe "EscalationLevel", type: :feature do
  let(:cs) { FactoryBot.create(:channel_statistic) }
  let(:el) { FactoryBot.create(:escalation_level, attrib: 'last_message_received_at') }
  let!(:ng) { FactoryBot.create(:notification_group, name: 'Default')}

  describe "show escalation level", js: true do
    it "visit show page" do
      login_user(role: 'Manager')
      visit escalation_level_path(el)
      expect(page).to have_content(el.escalatable.to_s)
      expect(page).to have_content("last_message_received_at")
    end
  end

  describe "create escalation level", js: true do
    it "creates new escalation level" do
      login_user(role: 'Admin')
      visit new_channel_statistic_escalation_level_path(cs)
      within "#new_escalation_level" do
        select "last_message_received_at", from: "escalation_level_attrib"
        fill_in "min_critical", with: -1440
        fill_in "min_warning", with: -240
        select "Default", from: "escalation_level_notification_group_id"
        check "escalation_level_show_on_dashboard"
      end
      click_button "Eskalationslevel erstellen"
      expect(page).to have_content("Eskalationslevel erfolgreich erstellt")
      el = EscalationLevel.last
      expect(current_path).to eq(channel_statistic_escalation_level_path(cs,el))
      expect(page).to have_content("Eskalationslevel: ##{el.id}")
      expect(page).to have_content("Default")
      expect(page).to have_content("true")
    end
  end

end
