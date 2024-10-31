# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Edit Profile", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  scenario "User edits profile successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to edit profile page
    visit edit_user_registration_path

    # User updates profile information
    fill_in "Email", with: "newemail@example.com"
    fill_in "Current password", with: user.password
    click_button "Update"

    # Debugging: Save and open the page to inspect it
    save_and_open_page

    expect(page).to have_content("You updated your account successfully")
  end

  scenario "User fails to edit profile with invalid data" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to edit profile page
    visit edit_user_registration_path

    # User attempts to update profile with invalid data
    fill_in "Email", with: "invalidemail"
    fill_in "Current password", with: user.password
    click_button "Update"

    expect(page).to have_content("Email is invalid")
  end
end
