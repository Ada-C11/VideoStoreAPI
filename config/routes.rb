Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/zomg", to: "customers#zomg"

<<<<<<< HEAD
  post "rentals/check-out", to: "rentals#checkout"
=======
  post "rentals/check-out", to: "rentals#checkout", as: "checkout"
>>>>>>> a8fb87d7b6d875a67516980b4294cafbf56ce4ea
  post "rentals/check-in", to: "rentals#checkin", as: "checkin"

  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]
end
