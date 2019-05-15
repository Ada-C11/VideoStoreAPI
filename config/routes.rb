Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'movies/', to: 'movies#index'

  # get 'movies/:id/', to: 'movies#show'

  resources :movies, only: [:index, :show, :create]

  # post 'movies/', to: 'movies#create'

  get '/customers', to: 'customers#index', as: 'customers'

  post '/rentals/checkin', to: 'rentals#checkin', as: 'checkin'

end

