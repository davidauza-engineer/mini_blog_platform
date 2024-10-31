# frozen_string_literal: true

module Comments
  class Builder
    def initialize(post:, author:, params:)
      @post = post
      @author = author
      @params = params
    end

    def call
      comment = post.comments.build(params)
      comment.author = author
      comment
    end

    private

    attr_reader :post, :author, :params
  end
end
