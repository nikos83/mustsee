# frozen_string_literal: true

FactoryBot.define do
  factory :film do
    title { Faker::Lorem.word }

    description { Faker::Lorem.sentence(3, true) }

    trait :cover_img do
      cover_img { fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'), 'image/jpg') }
    end
  end
end
