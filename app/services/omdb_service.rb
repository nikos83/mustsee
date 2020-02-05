# frozen_string_literal: true

class OmdbService
  include HTTParty
  base_uri 'www.omdbapi.com'

  def initialize(title, year)
    @options = { query: { t: title, y: year, apikey: Rails.application.credentials.dig(:omdb, :apikey) } }
  end

  def search
    self.class.get('', @options)
  end
end
