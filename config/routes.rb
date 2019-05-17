Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]
  # get "movies/index"
  # get "movies/show"
  # get "movies/create"
  resources :customers, only: [:index, :show, :create]

  post "/rentals/check-out", to: "rentals#check_out", as: "check_out"
  post "/rentals/check-in", to: "rentals#check_in", as: "check_in"

  # get "movies/zomg"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
