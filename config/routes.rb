Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources: :movies, only: [:index, :show, :create]
  ### get "/movies", to: movies#index
  ### get "/movies/:id", to: movies#show
  ### post "/movies", to: movies#create

  get "/customers", to: "customers#index"

  # Which controller do these routes route to?
  # post "/rentals/check-out", to:
  # post "/rentals/check-in", to:

end
