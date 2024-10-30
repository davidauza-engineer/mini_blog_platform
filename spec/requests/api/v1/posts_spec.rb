# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Api::V1::Posts requests", type: :request do
  let!(:posts) { create_list(:post, 10, author: author) }
  let(:post_id) { posts.first.id }
  let(:author) { create(:user) }

  describe "GET /api/v1/posts" do
    context "when fetching all posts" do
      before { get '/api/v1/posts' }

      it "returns posts" do
        expect(JSON.parse(response.body).count).to eq(10)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when fetching specific posts by ids" do
      before { get "/api/v1/posts", params: { ids: posts.map(&:id).join(',') } }

      it "returns the specified posts" do
        expect(JSON.parse(response.body).count).to eq(10)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET /api/v1/posts/:id" do
    before { get "/api/v1/posts/#{post_id}" }

    context "when the record exists" do
      it "returns the post" do
        expect(JSON.parse(response.body)['id']).to eq(post_id)
      end

      it "returns status code 200" do
        expect(response).to have_http_status(200)
      end
    end

    context "when the record does not exist" do
      let(:post_id) { 100 }

      it "returns status code 404" do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message" do
        expect(response.body).to match(/Couldn't find Post/)
      end
    end
  end

  describe "POST /api/v1/posts" do
    let(:valid_attributes) { { post: { title: 'Learn Elm', body: 'Elm is great for front-end development', author_id: author.id } } }

    context "when the request is valid" do
      before { post '/api/v1/posts', params: valid_attributes }

      it "creates a post" do
        expect(JSON.parse(response.body)['title']).to eq('Learn Elm')
      end

      it "returns status code 201" do
        expect(response).to have_http_status(201)
      end
    end

    context "when the request is invalid" do
      before { post '/api/v1/posts', params: { post: { title: 'Foobar' } } }

      it "returns status code 422" do
        expect(response).to have_http_status(422)
      end

      it "returns a validation failure message" do
        expect(JSON.parse(response.body)['body']).to match([ "can't be blank" ])
      end
    end
  end

  describe "PUT /api/v1/posts/:id" do
    let(:valid_attributes) { { post: { title: 'Shopping' } } }

    context "when the record exists" do
      before { put "/api/v1/posts/#{post_id}", params: valid_attributes }

      it "updates the record" do
        expect(response.body).to match(/Shopping/)
      end

      it "returns status code 204" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "DELETE /api/v1/posts/:id" do
    before { delete "/api/v1/posts/#{post_id}" }

    it "returns status code 204" do
      expect(response).to have_http_status(204)
    end
  end
end
