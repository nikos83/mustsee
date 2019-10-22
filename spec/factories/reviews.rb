# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 1 }
    review_body { 'MyText' }
    user
    association :film, :cover_img
  end
end
