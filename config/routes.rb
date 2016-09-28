Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"
  resources :graphs, only: [:index, :create]
end
