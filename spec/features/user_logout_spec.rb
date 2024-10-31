# spec/features/user_logout_spec.rb
# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Logout", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  scenario "User logs out successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User logs out
    click_button "Logout"

    expect(page).to have_content("Signed out successfully.")
    expect(page).to have_content("Login")
  end
end
