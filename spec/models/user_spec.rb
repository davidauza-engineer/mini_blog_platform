# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it "is valid with valid attributes" do
      user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
      expect(user).to be_valid
    end

    it "is not valid without an email" do
      user = User.new(email: nil)
      expect(user).to_not be_valid
    end

    it "is not valid without a password" do
      user = User.new(password: nil)
      expect(user).to_not be_valid
    end
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end
