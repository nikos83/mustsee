# frozen_string_literal: true

Rails.application.routes.draw do
  get 'omdb/index'
  get 'omdb/search'
  resources :films do
    resources :attachments, only: :destroy
    resources :reviews
    get 'search'
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
