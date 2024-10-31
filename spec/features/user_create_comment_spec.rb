# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Create Comment", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }
  let(:post) { create(:post, title: "Sample Post", body: "This is a sample post.", author: user) }

  scenario "User creates a comment successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User fills in comment details
    fill_in "comment_body", with: "This is a comment."
    click_button "Post Comment"

    expect(page).to have_content("Comment was successfully created.")
    expect(page).to have_content("This is a comment.")
  end

  scenario "User fails to create a comment with invalid data" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User attempts to create a comment with invalid data
    fill_in "comment_body", with: ""
    click_button "Post Comment"

    expect(page).to have_content("Error creating comment")
  end
end
