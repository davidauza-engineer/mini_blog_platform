# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Delete Comment", type: :feature do
  let(:user) { create(:user, :author, email: "user@example.com", password: "password") }
  let(:post) { create(:post, title: "Sample Post", body: "This is a sample post.", author: user) }
  let(:comment) { create(:comment, body: "Comment to be deleted", post: post, author: user) }

  before { comment }

  scenario "User deletes a comment successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User deletes the comment
    all("button", text: "Delete")[1].click

    expect(page).to have_content("Comment was successfully destroyed.")
    expect(page).not_to have_content("Comment to be deleted")
  end
end
