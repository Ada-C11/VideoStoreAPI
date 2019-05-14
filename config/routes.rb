Rails.application.routes.draw do
  get 'zomg/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index]
  resources :movies, only: [:index, :show]
  get "/zomg", to: "zomg#index", as: "zomg"
end
