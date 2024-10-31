# frozen_string_literal: true

class Post < ApplicationRecord
  include PgSearch::Model

  pg_search_scope :search_by_title_and_body,
                  against: [ :title, :body ],
                  using: {
                    tsearch: { prefix: true }
                  }

  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true
  validates :body, presence: true

  paginates_per 9
end
