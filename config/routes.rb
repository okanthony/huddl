Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"

  resources :games, only: [:new, :create, :edit, :update, :index]
end
