# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]
  get "/zomg", to: "movies#zomg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
