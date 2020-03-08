# frozen_string_literal: true

Rails.application.routes.draw do
  resources :films do
    resources :attachments, only: :destroy
    resources :reviews
  end
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  root to: 'home#index'
end
