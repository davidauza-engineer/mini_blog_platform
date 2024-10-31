# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class }

  let(:user) { User.new }
  let(:author) { User.new(role: 'author') }
  let(:comment) { Comment.new(author: author) }

  permissions :update? do
    it 'allows authors to update their own comments' do
      expect(subject).to permit(author, comment)
    end

    it 'does not allow non-authors to update comments' do
      expect(subject).not_to permit(user, comment)
    end
  end

  permissions :destroy? do
    it 'allows authors to destroy their own comments' do
      expect(subject).to permit(author, comment)
    end

    it 'does not allow non-authors to destroy comments' do
      expect(subject).not_to permit(user, comment)
    end

    it 'does not allow authors to destroy comments they did not create' do
      another_author = User.new(role: 'author')
      another_comment = Comment.new(author: another_author)
      expect(subject).not_to permit(author, another_comment)
    end
  end
end
