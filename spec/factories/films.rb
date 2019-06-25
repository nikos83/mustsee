# frozen_string_literal: true

FactoryBot.define do
  factory :film do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence(3, true) }
    cover_img do
      temp.photo.attach(
        io: File.open('storage/Mf/nZ/MfnZE5xKX6yaGStkK9YmvxgU'),
        filename: 'file.png'
      )
    end
  end
end
