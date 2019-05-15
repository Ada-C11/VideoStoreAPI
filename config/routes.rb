Rails.application.routes.draw do
  get "rentals/check-out"
  post "rentals/check-out", to: "rentals#check_out", as: "new_check_out"

  get "rentals/check-in"
  post "rentals/check-in", to: "rentals#check_in", as: "check_in"

  get "zomg/index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]
  get "/zomg", to: "zomg#index", as: "zomg"
end
