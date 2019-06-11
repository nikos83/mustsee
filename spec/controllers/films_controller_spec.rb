# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  describe 'GET #index' do
    it 'returns http error must be logged in' do
      get :index
      expect(response).to have_http_status(302)
    end
  end
end
