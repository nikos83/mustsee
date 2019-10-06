# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :film

  validates :rating, presence: true
  validates :user_id, uniqueness: {
    scope: :film_id, message: "You're only allowed to have one comment per film."
  }
end
