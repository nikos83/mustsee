# frozen_string_literal: true

class FilmDecorator < Draper::Decorator
  delegate_all

  def delete_link
    - if object.film_link.attached?
        h.link_to 'Remove Film', h.delete_film_link_attachment_film_url(object.film_link.id),
                  method: :delete, data: { confirm: 'Are you sure?' }, class: 'btn btn-warning'
      else
        'No film attached'
      end
  end
end
