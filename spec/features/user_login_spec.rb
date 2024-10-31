# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Login", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  scenario "User logs in successfully" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Logout")
  end

  scenario "User login fails with invalid credentials" do
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: "wrongpassword"
    click_button "Log in"

    expect(page).to have_content("Invalid Email or password.")
  end
end
