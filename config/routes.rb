Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index]

  resources :movies, only: [:index, :show, :create]

  post "rentals/check-out", as: "checkout"
  post "rentals/check-in", as: "checkin"
end
