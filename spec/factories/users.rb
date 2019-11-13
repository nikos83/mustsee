# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    trait :confirmed do
      confirmed_at { Time.now }
    end
    trait :admin do
      admin { true }
    end
  end
end
