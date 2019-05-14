Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies, only:[:index, :show, :create]
  resources :customer, only:[:index, :show, :create]
  post 'rentals/check-out', to: 'rentals#check-out', as:'check-out'
  post 'rentals/check-in', to: 'rentals#check-in', as:'check-in'
end
