# frozen_string_literal: true

class Film < ApplicationRecord
  has_one_attached :cover_img
  has_one_attached :film_link
  validates :title, presence: true
  validate :check_cover

  private

  def check_cover
    if cover_img.attached? && !cover_img.attachment.blob.content_type.in?(%w[image/png image/jpeg])
      errors.add(:cover_img, 'Must be an image file')
    elsif cover_img.attached? == false
      errors.add(:cover_img, 'Cover img must be attached')
    end
  end
end