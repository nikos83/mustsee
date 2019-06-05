# frozen_string_literal: true

class Film < ApplicationRecord
  has_one_attached :cover_img
  has_one_attached :film_link
end
