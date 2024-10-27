# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/sign_up" do
    it "returns a successful response" do
      get new_user_registration_path
      expect(response).to be_successful
    end
  end

  describe "POST /users" do
    it "creates a new user" do
      expect {
        post user_registration_path, params: { user: { email: "test@example.com", password: "password", password_confirmation: "password" } }
      }.to change(User, :count).by(1)
    end
  end

  describe "GET /users/sign_in" do
    it "returns a successful response" do
      get new_user_session_path
      expect(response).to be_successful
    end
  end

  describe "POST /users/sign_in" do
    let(:user) { User.create(email: "test@example.com", password: "password", password_confirmation: "password", confirmed_at: Time.now) }

    it "logs in the user" do
      post user_session_path, params: { user: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE /users/sign_out" do
    let(:user) { User.create(email: "test@example.com", password: "password", password_confirmation: "password", confirmed_at: Time.now) }

    before do
      sign_in user
    end

    it "logs out the user" do
      delete destroy_user_session_path
      expect(response).to redirect_to(root_path)
    end
  end
end
