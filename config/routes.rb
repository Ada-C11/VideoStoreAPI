Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :show]
  resources :movies, only: [:index, :show, :create]
  post "rentals/check-out", to: "rentals#check_out", as: "rentals_check_out"
  post "rentals/check-in", to: "rentals#check_in", as: "rentals_check_in"
end
