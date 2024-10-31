# frozen_string_literal: true

require 'rails_helper'

RSpec.feature "Posts caching", type: :feature do
  scenario "caches the list of posts on the homepage" do
    # Create a user and sign in
    user = create(:user)
    sign_in(user)

    # Create a spy to track the cache method calls
    cache_spy = spy('cache')
    allow_any_instance_of(ActionView::Base).to receive(:cache).and_wrap_original do |method, *args, &block|
      cache_spy.call(*args)
      method.call(*args, &block)
    end

    # Create a post
    post = create(:post, title: "First Post", body: "This is the first post", author: user)

    # Visit the homepage
    visit root_path

    # Check that the post is displayed
    expect(page).to have_content("First Post")

    # Check that the cache is created
    expect(cache_spy).to have_received(:call).with([ post ], expires_in: 1.hour).once

    # Create another post
    post_two = create(:post, title: "Second Post", body: "This is the second post", author: user)

    # Visit the homepage again
    visit root_path

    # Check that the new post is displayed (cache should be expired)
    expect(page).to have_content("Second Post")

    # Check that the cache is expired and recreated
    expect(cache_spy).to have_received(:call).with([ post, post_two ], expires_in: 1.hour).once
  end
end
