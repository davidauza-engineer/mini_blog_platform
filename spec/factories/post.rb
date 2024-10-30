# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { "Post title" }
    body { "Post body" }
    association :author, factory: :user
  end
end
