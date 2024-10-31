# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "User Delete Post", type: :feature do
  let(:user) { create(:user, :author, email: "user@example.com", password: "password") }
  let!(:post) { create(:post, title: "Post to be deleted", body: "This post will be deleted", author: user) }

  scenario "User deletes a post successfully" do
    # User logs in first
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    # User navigates to the post page
    visit post_path(post)

    # User deletes the post
    click_button "Delete"

    expect(page).to have_content("Post was successfully destroyed.")
    expect(page).not_to have_content("Post to be deleted")
    expect(page).not_to have_content("This post will be deleted")
  end
end
