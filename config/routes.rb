Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]

  get "/zomg", to: "customers#zomg", as: "zomg"

  
  resources :rentals
  post "rentals/check-out", to: "rentals#checkout", as: "checkout"
  post "rentals/check-in", to: "rentals#checkin", as: "checkin"
end


