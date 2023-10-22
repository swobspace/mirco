# -*- encoding : utf-8 -*-
require 'rails_helper'

describe "Login", type: :feature do
  # fixtures 'wobauth/roles'
  let!(:user) do
    FactoryBot.create(:user, 
      username: 'tester',
      password: 'test9999',
      password_confirmation: 'test9999'
    )
  end

  context "with rights = nobody" do
    describe "GET /", :js => true do
      it "redirects to login form" do
	visit root_path
	expect(page).to have_content("not logged in")
      end
    end

    describe "GET /user_sessions/new", :js => false do
      it "login as tester via login form" do
	visit wobauth.login_path
        fill_in "Username", :with => 'tester'
        fill_in "Password", :with => 'test9999'
        click_button 'Log in'
        expect(page).to have_content("Erfolgreich angemeldet")
        expect(page).to have_content("tester")
      end

#      it "should not login with disabled tester" do
#        user.update_attribute(:disabled, true)
#	visit new_user_session_path
#        fill_in "Username", :with => 'tester'
#        fill_in "Passwort", :with => 'test9999'
#        click_button 'Login'
#        expect(page).not_to have_content("Login successful")
#        expect(page).to have_content("Login incorrect!")
#        expect(page).to have_content("Your account is not active")
#      end
    end

  end
end
