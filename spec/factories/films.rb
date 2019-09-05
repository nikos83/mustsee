# frozen_string_literal: true

FactoryBot.define do
  factory :film do
    title { Faker::Lorem.word }

    description { Faker::Lorem.sentence(3, true) }

    trait :cover_img do
      cover_img { fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'), 'image/jpg') }
    end

    trait :film_link do
      film_link { fixture_file_upload(Rails.root.join('spec', 'assets', 'test.mp4'), 'video/mp4') }
    end

    trait :cover_img_wrong do
      cover_img { fixture_file_upload(Rails.root.join('spec', 'assets', 'test.mp4'), 'video/mp4') }
    end

    trait :film_link_wrong do
      film_link { fixture_file_upload(Rails.root.join('spec', 'assets', 'test.jpg'), 'image/jpg') }
    end

    trait :cover_img_nil do
      cover_img { nil }
    end

    trait :film_link_nil do
      film_link { nil }
    end
  end
end
