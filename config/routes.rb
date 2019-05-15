Rails.application.routes.draw do
  get 'rentals/check_out'
  get 'rentals/check_in'
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get /customers
  # get /movies
  # get /movies/:id  <=== id
  # post /movies

  # post /rentals/check-out <==== customer id, movie id
  # post /rentals/check-in <==== customer id, movie id
end
