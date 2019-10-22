# frozen_string_literal: true

class FilmDecorator < Draper::Decorator
  delegate_all

  def delete_link
    if object.film_link.attached?
      h.link_to 'Delete Film', h.film_attachment_path(object, object.film_link.id),
                method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-warning'
    else
      'No film attached'
    end
  end

  def rating_avg
    'Average ratings: ' + object.reviews.average(:rating).round(2).to_s if object.reviews.exists?
  end
end
