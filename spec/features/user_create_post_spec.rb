# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Create Post", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  scenario "User creates a post successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to new post page
    visit new_post_path

    # User fills in post details
    fill_in "Title", with: "My First Post"
    fill_in "Body", with: "This is the content of my first post."
    click_button "Save Post"

    expect(page).to have_content("Post was successfully created.")
    expect(page).to have_content("My First Post")
    expect(page).to have_content("This is the content of my first post.")
  end

  scenario "User fails to create a post with invalid data" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to new post page
    visit new_post_path

    # User attempts to create a post with invalid data
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Save Post"

    expect(page).to have_content("Error creating post")
  end
end
