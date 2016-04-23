Rails.application.routes.draw do
  devise_for :users
  root "welcome#index"

  resources :games do
    resources :confirmations do
      collection do
        post "claim"
        post "unclaim"
      end
    end
  end
end
