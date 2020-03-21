# frozen_string_literal: true

class OmdbService
  include HTTParty
  base_uri 'www.omdbapi.com'

  def initialize(title, year)
    @options = { query: { t: title, y: year, apikey: Rails.application.credentials.dig(:omdb, :apikey) } }
  end

  def search
    self.class.get('', @options)
  rescue HTTParty::Error => e
    inspect_errors(e)
  rescue StandardError => e
    inspect_errors(e)
  end

  def search_result
    search || NullOmdb.new
  end

  private

  def inspect_errors(error)
    puts error.inspect
  end
end
