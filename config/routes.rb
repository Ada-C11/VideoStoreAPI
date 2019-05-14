# frozen_string_literal: true

Rails.application.routes.draw do
  get 'customers/index'
  get 'customers/show'
  get 'movies/index'
  get 'movies/show'
  get 'movies/create'
  get '/zomg', to: 'movies#zomg'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
