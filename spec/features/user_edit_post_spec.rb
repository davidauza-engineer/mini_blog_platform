# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Edit Post", type: :feature do
  let(:user) { create(:user, :author, email: "user@example.com", password: "password") }
  let(:post) { create(:post, title: "Original Title", body: "Original content", author: user) }

  scenario "User edits a post successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to edit post page
    visit edit_post_path(post)

    # User updates post details
    fill_in "Title", with: "Updated Title"
    fill_in "Body", with: "Updated content"
    click_button "Save Post"

    expect(page).to have_content("Post was successfully updated.")
    expect(page).to have_content("Updated Title")
    expect(page).to have_content("Updated content")
  end

  scenario "User fails to edit a post with invalid data" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to edit post page
    visit edit_post_path(post)

    # User attempts to update post with invalid data
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Save Post"

    expect(page).to have_content("Error updating post")
  end
end
