# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Builder, type: :service do
  describe '#call' do
    let(:post) { create(:post) }
    let(:author) { create(:user) }
    let(:params) { attributes_for(:comment) }
    let(:builder) { described_class.new(post: post, author: author, params: params) }

    subject(:new_comment) { builder.call }

    it 'creates a built (unsaved) comment associated with the post and author' do
      expect(new_comment).to be_a_new(Comment)
      expect(new_comment.post).to eq(post)
      expect(new_comment.author).to eq(author)
      expect(new_comment.attributes).to include(params.stringify_keys)
    end
  end
end
