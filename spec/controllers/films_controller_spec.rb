# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilmsController, type: :controller do
  render_views
  let!(:film) { create :film, :cover_img }

  describe 'get #index' do
    context "when user isn't logged in" do
      before do
        get :index
      end

      it 'redirect to login page' do
        expect(response.status).to be 302
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        get :index
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        get :index
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'returns films' do
        expect(response.body).to have_content(film.title)
      end
    end

    context 'when admin is logged in' do
      login_admin
      before do
        get :index
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'returns films' do
        expect(response.body).to have_content(film.title)
      end
    end
  end

  describe 'GET #show' do
    context "when user isn't logged in" do
      before do
        get :show, params: { id: film.id }
      end

      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        get :show, params: { id: film.id }
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        get :show, params: { id: film.id }
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'returns films' do
        expect(response.body).to have_content(film.title)
      end
    end

    context 'when admin is logged in' do
      login_admin
      before do
        get :show, params: { id: film.id }
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'returns films' do
        expect(response.body).to have_content(film.title)
      end

      it 'have edit' do
        expect(response.body).to have_link('Edit', href: edit_film_path(film))
      end

      it 'have delete' do
        expect(response.body).to have_link('Delete all')
      end
    end
  end

  describe 'GET #new' do
    context "when user isn't logged in" do
      before do
        get :new
      end

      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        get :new
      end

      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        get :new
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end

    context 'when admin is logged in' do
      login_admin
      before do
        get :new
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'have input' do
        expect(response.body).to have_selector("input[name='film[title]']")
      end
    end
  end

  describe 'GET #edit' do
    context "when user isn't logged in" do
      before do
        get :edit, params: { id: film }
      end

      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        get :edit, params: { id: film }
      end

      it 'redirects to login page' do
        expect(response.status).to be 302
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        get :edit, params: { id: film }
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end

    context 'when admin is logged in' do
      login_admin
      before do
        get :edit, params: { id: film }
      end

      it 'have correct response' do
        expect(response.status).to be 200
      end

      it 'have input' do
        expect(response.body).to have_selector("input[name='film[title]']")
      end

      it 'have data' do
        expect(response.body).to have_selector("input[value='#{film.title}']")
      end
    end
  end

  describe 'POST #delete' do
    context "when user isn't logged in" do
      before do
        post :destroy, params: { id: film }
      end

      it 'redirects to login with notice' do
        expect(response.status).to be 302
        expect(flash[:alert]).to eql('You need to sign in or sign up before continuing.')
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        post :destroy, params: { id: film }
      end

      it 'redirects to login with notice' do
        expect(response.status).to be 302
        expect(flash[:alert]).to eql('You have to confirm your email address before continuing.')
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        post :destroy, params: { id: film }
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end

    context 'when admin is logged in' do
      login_admin

      it 'delete record' do
        expect { delete :destroy, params: { id: film.id } }.to change(Film, :count).by(-1)
        expect(flash[:notice]).to eq 'Films was successfully destroyed.'
      end
    end
  end

  describe 'Search api' do
    context "when user isn't logged in" do
      before do
        get :new, params: { search: 'Terminator', year: '2019' }
      end

      it 'redirects to login with notice' do
        expect(response.status).to be 302
        expect(flash[:alert]).to eql('You need to sign in or sign up before continuing.')
      end
    end

    context "when user isn't confirmed" do
      login_unconfirmed
      before do
        get :new, params: { search: 'Terminator', year: '2019' }
      end

      it 'redirects to login with notice' do
        expect(response.status).to be 302
        expect(flash[:alert]).to eql('You have to confirm your email address before continuing.')
      end
    end

    context 'when user is logged in' do
      login_user
      before do
        get :new, params: { search: 'Terminator', year: '2019' }
      end

      it 'have correct response' do
        expect(response.status).to be 302
      end
    end
    context 'when admin logged in' do
      login_admin

      it 'should place results into input and picture' do
        VCR.use_cassette('omdb/terminator_2019') do
          get :new, params: { search: 'Terminator', year: '2019' }
          expect(response.body).to have_selector("input[value='Terminator: Dark Fate']")
          expect(response.body).to have_selector('img')
        end
      end
      it 'should show error' do
        VCR.use_cassette('omdb/empty_string') do
          get :new, params: { search: '', year: '' }
          expect(response.body).to have_content('Something went wrong.')
        end
      end
      it 'should return not found' do
        VCR.use_cassette('omdb/wrong_params') do
          get :new, params: { search: 'Sadsau39@', year: '230293' }
          expect(response.body).to have_content('Movie not found!')
        end
      end
      it 'should return error' do
        VCR.use_cassette('omdb/nil_params') do
          get :new, params: { search: nil, year: nil }
          expect(response.body).to have_content('Something went wrong.')
        end
      end

      it 'should return error' do
        VCR.use_cassette('omdb/terminator_1991') do
          stub_request(:any, /omdbapi.com/).to_raise(StandardError)
          get :new, params: { search: 'Terminator', year: '1991' }
          expect(response.body).to have_content('Something went wrong! Please find you log file for more details')
        end
      end
    end
  end
end
