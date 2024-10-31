# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Registration", type: :feature do
  scenario "User registers successfully" do
    visit new_user_registration_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"

    expect(page).to have_content("Welcome to Mini Blog Platform")
    expect(User.last.email).to eq("user@example.com")
  end

  scenario "User registration fails with invalid data" do
    visit new_user_registration_path

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "wrongpassword"
    click_button "Sign up"

    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
