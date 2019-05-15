Rails.application.routes.draw do
  resources :movies, only: [:index, :show, :create]
  resources :customers, only: [:index]

  post "/rentals/checkin", to: "rentals#checkin", as: "checkin"
end
