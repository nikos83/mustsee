# frozen_string_literal: true

Rails.application.routes.draw do
  resources :films do
    resources :attachments, only: :destroy
    resources :reviews
    resources :omdb, only: %i[index search]
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
