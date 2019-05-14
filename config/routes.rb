Rails.application.routes.draw do
  get 'movies/index'
  get 'movies/zomg'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get /customers
  # get /movies
  # get /movies/:id  <=== id
  # post /movies

  # post /rentals/check-out <==== customer id, movie id
  # post /rentals/check-in <==== customer id, movie id
end
