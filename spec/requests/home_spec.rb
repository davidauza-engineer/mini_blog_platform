# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Home requests", type: :request do
  describe "GET /index" do
    context "when user is signed in" do
      let(:user) { create(:user) }
      let(:posts) { create_list(:post, 20, author: user) }

      before do
        sign_in user
        posts
      end

      it "returns a successful response" do
        get root_path
        expect(response).to have_http_status(:success)
      end

      it "includes the posts in the response body" do
        get root_path
        posts.first(10).each do |post|
          expect(response.body).to include(post.title)
        end
      end

      it "renders the index template" do
        get root_path
        expect(response).to render_template("home/index")
      end

      context "when paginating posts" do
        it "returns the first page of posts" do
          get root_path, params: { page: 1 }
          expect(response.body).to match(/#{posts.first.title}/)
        end

        it "returns the second page of posts" do
          get root_path, params: { page: 2 }
          expect(response.body).to match(/#{posts[10].title}/)
        end
      end

      context "when searching for posts" do
        let!(:search_post) { create(:post, title: 'UniqueTitle', body: 'UniqueBody', author: user) }

        it "returns the matching posts" do
          get root_path, params: { query: 'Unique' }
          expect(response.body).to include('UniqueTitle')
        end

        it "returns a successful response" do
          get root_path, params: { query: 'Unique' }
          expect(response).to have_http_status(:success)
        end
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
