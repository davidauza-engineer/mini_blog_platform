# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "password" }
    confirmed_at { Time.now }
  end
end
