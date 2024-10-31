# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Posts requests", type: :request do
  let(:user) { create(:user, :author) }
  let(:post_instance) { create(:post, author: user) }

  before do
    sign_in user
  end

  describe "GET /show" do
    it "returns a successful response" do
      get post_path(post_instance)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns a successful response" do
      get new_post_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns a successful response" do
      get edit_post_path(post_instance)
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:post_params) { attributes_for(:post) }
    let(:image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png') }

    it "creates a new post" do
      expect {
        post posts_path, params: { post: post_params.merge(image: image) }
      }.to change(Post, :count).by(1)
    end

    it "attaches an image to the post" do
      post posts_path, params: { post: post_params.merge(image: image) }
      expect(Post.last.image).to be_attached
    end

    it "redirects to the created post" do
      post posts_path, params: { post: post_params.merge(image: image) }
      expect(response).to redirect_to(post_path(Post.last))
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { title: "Updated Title" } }
    let(:new_image) { fixture_file_upload(Rails.root.join('spec/fixtures/files/new_test_image.png'), 'image/png') }

    it "updates the requested post" do
      patch post_path(post_instance), params: { post: new_attributes }
      post_instance.reload
      expect(post_instance.title).to eq("Updated Title")
    end

    it "updates the image of the post" do
      patch post_path(post_instance), params: { post: new_attributes.merge(image: new_image) }
      post_instance.reload
      expect(post_instance.image).to be_attached
    end

    it "redirects to the post" do
      patch post_path(post_instance), params: { post: new_attributes }
      expect(response).to redirect_to(post_path(post_instance))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested post" do
      post_instance
      expect {
        delete post_path(post_instance)
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the root path" do
      delete post_path(post_instance)
      expect(response).to redirect_to(root_path)
    end
  end
end
