# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: "User"

  validates :body, presence: true

  paginates_per 10
end
