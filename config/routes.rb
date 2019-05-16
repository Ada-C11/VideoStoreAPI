Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index, :show, :create]
  
  post '/rentals/checkout', to: 'rentals#checkout', as: 'checkout'
end
