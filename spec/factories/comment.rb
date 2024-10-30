# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    body { "MyText" }
    association :author, factory: :user
    association :post, factory: :post
  end
end
