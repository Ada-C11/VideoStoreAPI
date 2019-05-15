Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :movies, only: [:index, :show, :create]

  get "/customers", to: "customers#index", as: "customers"

  # Which controller do these routes route to?
  post "/rentals/check-out", to: "movies#checkout", as: "checkout"
  post "/rentals/check-in", to: "movies#checkin", as: "checkin"
end
