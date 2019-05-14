Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :customers, only: [:index, :show, :create]
  resources :movies, only: [:index, :show, :create]

  get "/zomg", to: "customers#zomg", as: "zomg"

# GET /movies show all movies
# GET /movies/:id shows a movie with the provided id
# POST /movies add a movie to the collection
end


