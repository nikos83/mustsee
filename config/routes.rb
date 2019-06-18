# frozen_string_literal: true

Rails.application.routes.draw do
  resources :films do
    member do
      delete :delete_film_link_attachment
    end
  end
  devise_for :users
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
