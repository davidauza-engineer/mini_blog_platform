# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy do
  subject { described_class }

  let(:user) { User.new }
  let(:author) { User.new(role: 'author') }
  let(:post) { Post.new(author: author) }

  permissions :update? do
    it 'allows authors to update their own posts' do
      expect(subject).to permit(author, post)
    end

    it 'does not allow non-authors to update posts' do
      expect(subject).not_to permit(user, post)
    end
  end

  permissions :destroy? do
    it 'allows authors to destroy their own posts' do
      expect(subject).to permit(author, post)
    end

    it 'does not allow non-authors to destroy posts' do
      expect(subject).not_to permit(user, post)
    end

    it 'does not allow authors to destroy posts they did not create' do
      another_author = User.new(role: 'author')
      another_post = Post.new(author: another_author)
      expect(subject).not_to permit(author, another_post)
    end
  end
end
