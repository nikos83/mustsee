# frozen_string_literal: true

class OmdbDecorator < Draper::Decorator
  delegate_all

  def show_api_poster
    if check_poster_presence
      h.image_tag object.parsed_response['Poster']
    else
      object.parsed_response['Error']
    end
  end

  def check_poster_presence
    object.parsed_response['Poster'].present? && object.parsed_response['Poster'] != 'N/A'
  end
end
