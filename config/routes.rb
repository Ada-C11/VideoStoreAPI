Rails.application.routes.draw do
  # get 'rentals/check_out'
  # get 'rentals/check_in'
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]

  post "rentals/check-out", to: "rentals#check_out", as: "check_out"

  # post /rentals/check-out <==== customer id, movie id
  # post /rentals/check-in <==== customer id, movie id
end
