Rails.application.routes.draw do
  get 'rentals/index'
  get 'rentals/show'
  get 'rentals/create'
  get 'customers/index'
  get 'customers/show'
  get 'customers/create'
  get 'movies/index'
  get 'movies/show'
  get 'movies/create'
  get 'movies/zomg'
  get "/zomg", to: "movies#zomg"
end
