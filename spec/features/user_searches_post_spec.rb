# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Search Post", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }
  let!(:post1) { create(:post, title: "First Post", body: "This is the first post.", author: user) }
  let!(:post2) { create(:post, title: "Second Post", body: "This is the second post.", author: user) }

  before do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  scenario "User searches for a post successfully" do
    # User navigates to the posts index page
    visit root_path

    # User enters a search query in the search bar and submits the form
    fill_in "query", with: "First Post"
    click_button "Search"

    # Verify that the search results are displayed correctly
    expect(page).to have_content("First Post")
    expect(page).not_to have_content("Second Post")
  end
end
