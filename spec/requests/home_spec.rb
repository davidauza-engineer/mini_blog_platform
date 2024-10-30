# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Home requests", type: :request do
  describe "GET /index" do
    context "when user is signed in" do
      before do
        user = create(:user)
        sign_in user
        @posts = create_list(:post, 3, author: user)
      end

      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "includes the posts in the response body" do
        get root_path
        @posts.each do |post|
          expect(response.body).to include(post.title)
        end
      end

      it "renders the index template" do
        get root_path
        expect(response).to render_template("home/index")
      end
    end

    context "when user is not signed in" do
      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "does not include posts in the response body" do
        get root_path
        expect(response.body).not_to include("Post Title")
      end

      it "renders the index template" do
        get root_path
        expect(response).to render_template("home/index")
      end
    end
  end
end
