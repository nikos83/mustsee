# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbService do
  subject(:omdb_service) { described_class.new('Terminator', '2019') }
  context 'Api search and no errors' do
    let(:omdb_url) { 'www.omdbapi.com' }
    let(:omdb_response) { instance_double(HTTParty::Response, body: omdb_response_body) }
    let(:omdb_response_body) { 'Terminator: Dark Fate' }

    it 'fetches Title from api service' do
      VCR.use_cassette('omdb/terminator_2019') do
        expect(omdb_service.search_result.parsed_response['Title']).to eq('Terminator: Dark Fate')
      end
    end
  end

  context 'when nil come in' do
    let(:omdb_url) { 'www.omdbapi.com' }
    let(:omdb_response) { instance_double(HTTParty::Response, body: omdb_response_body) }
    let(:omdb_response_body) { nil }

    it 'fetches error from nullobject' do
      expect(omdb_service.search_result.parsed_response['Error']).to eq(
        'Something went wrong! Please find you log file for more details'
      )
    end
  end
end
