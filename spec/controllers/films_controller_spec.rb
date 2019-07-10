# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  render_views
  let!(:film) { create :film, :cover_img }
  describe 'not logged in' do
    describe 'get #index' do
      before do
        get :index
      end
      it 'redirect to login page' do
        expect(response.status).to be 302
      end
    end
    
    describe 'get #show page' do
      before do
        get :show, params: { id: film }
      end
      it 'redirect with message' do
        expect(response.body).to have_content('You are being redirected.')
      end

      it 'redirect to login page' do
        expect(response.status).to be 302
      end
    end

    describe 'GET #new' do
      before do
        get :new
      end
      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    describe 'GET #edit' do
      before do
        get :edit, params: { id: film }
      end
      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    describe 'post #delete' do
      before do
        post :destroy, params: { id: film }
      end
      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end
  end

  describe 'logged in as user' do
    login_user
    describe 'get #index' do
      before do
        get :index
      end
      it 'returns correct response' do
        expect(response.status).to be 200
      end

      it 'returns film' do
        expect(response.body).to have_content(film.title)
      end
    end

    describe 'GET #show' do
      before do
        get :show, params: { id: film }
      end
      it 'show created film' do
        expect(response.body).to have_content(film.description)
      end
    end
  end
end
