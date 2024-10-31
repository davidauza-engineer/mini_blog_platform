# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Edit Comment", type: :feature do
  let(:user) { create(:user, :author, email: "user@example.com", password: "password") }
  let(:post) { create(:post, title: "Sample Post", body: "This is a sample post.", author: user) }
  let(:comment) { create(:comment, body: "Original comment", post: post, author: user) }

  scenario "User edits a comment successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User navigates to edit comment page
    visit edit_post_comment_path(post, comment)

    # User updates comment details
    fill_in "comment_body", with: "Updated comment"
    click_button "Update Comment"

    expect(page).to have_content("Comment was successfully updated.")
    expect(page).to have_content("Updated comment")
  end

  scenario "User fails to edit a comment with invalid data" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User navigates to edit comment page
    visit edit_post_comment_path(post, comment)

    # User attempts to update comment with invalid data
    fill_in "comment_body", with: ""
    click_button "Update Comment"

    expect(page).to have_content("Error updating comment")
  end
end
