Rails.application.routes.draw do
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show, :create]

  post "/rentals/check-in", to: "rentals#check_in", as: "check-in"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
