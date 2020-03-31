# frozen_string_literal: true

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :webmock
  c.filter_sensitive_data('<OMDB_API_KEY>') { Rails.application.credentials.dig(:omdb, :apikey) }
end
