Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  unauthenticated :user do
    root to: "welcome#index", as: "unauthenticated_root"
  end

  authenticated :user do
    root to: "home#index", as: "authenticated_root"
  end

  get "/createteam" => "selector#index"
  get "/home" => "home#index"

  resources :selector, only: [:index]
  resources :teams, only: [:create]

  resources :games do
    resources :confirmations do
      collection do
        post "claim"
      end
    end
  end
end
