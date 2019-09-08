# frozen_string_literal: true

class Film < ApplicationRecord
  extend FriendlyId
  has_one_attached :cover_img, dependent: :purge_later
  has_one_attached :film_link, dependent: :purge_later
  validates :title, presence: true
  validate :check_cover, :check_film
  validates :slug, presence: true, uniqueness: true, allow_nil: false

  friendly_id :title, use: :slugged

  private

  def check_cover
    if cover_img.attached? && !cover_img.attachment.blob.content_type.in?(%w[image/png image/jpeg])
      errors.add(:cover_img, 'Must be an image file')
    elsif cover_img.attached? == false
      errors.add(:cover_img, 'Cover img must be attached')
    end
  end

  def check_film
    errors.add(:film_link, 'Must be an mp4 video file') if
    film_link.attached? && !film_link.attachment.blob.content_type.in?(%w[video/mp4])
  end
end
