# frozen_string_literal: true

Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show]

  post "rentals/check-out", to: "rentals#checkout", as: "checkout"
  post "rentals/check-in", to: "rentals#checkin", as: "checkin"

  get "/zomg", to: "movies#zomg"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
