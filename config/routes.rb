Rails.application.routes.draw do
  get "movies/index"

  get "movies/show"
  get "movies/create"
  get "customers/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]

  post "/rentals/check_out", to: "rentals#check_out", as: "check_out"
  post "/rentals/check_in", to: "rentals#check_in", as: "check_in"

  get "/zomg", to: "application#test", as: "test"
end
