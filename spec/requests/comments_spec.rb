# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Comments requests", type: :request do
  let(:user) { create(:user, :author) }
  let(:post_instance) { create(:post, author: user) }
  let(:comment) { create(:comment, post: post_instance, author: user) }

  before do
    sign_in user
  end

  describe "POST /create" do
    let(:comment_params) { attributes_for(:comment) }

    it "creates a new comment" do
      expect {
        post post_comments_path(post_instance), params: { comment: comment_params }
      }.to change(Comment, :count).by(1)
    end

    it "enqueues a CommentNotificationJob" do
      expect {
        post post_comments_path(post_instance), params: { comment: comment_params }
      }.to change(CommentNotificationJob.jobs, :size).by(1)
    end

    it "redirects to the post" do
      post post_comments_path(post_instance), params: { comment: comment_params }
      expect(response).to redirect_to(post_path(post_instance))
    end
  end

  describe "GET /edit" do
    it "returns a successful response" do
      get edit_post_comment_path(post_instance, comment)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { body: "Updated comment body" } }

    it "updates the requested comment" do
      patch post_comment_path(post_instance, comment), params: { comment: new_attributes }
      comment.reload
      expect(comment.body).to eq("Updated comment body")
    end

    it "redirects to the post" do
      patch post_comment_path(post_instance, comment), params: { comment: new_attributes }
      expect(response).to redirect_to(post_path(post_instance))
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested comment" do
      comment
      expect {
        delete post_comment_path(post_instance, comment)
      }.to change(Comment, :count).by(-1)
    end

    it "redirects to the post" do
      delete post_comment_path(post_instance, comment)
      expect(response).to redirect_to(post_path(post_instance))
    end
  end
end
