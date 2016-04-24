Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"
  get "/home" => "home#index"

  resources :games do
    resources :confirmations do
      collection do
        post "claim"
      end
    end
  end
end
