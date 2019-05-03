Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root 'products#index'
  resources :products
  resources :mypages, only: [:index] do
    resources :cards
  end
  resources :profiles, only: [:index]
  resources :logouts, only: [:index]
  resources :identifications, only: [:index]
  resources :users
  post "statuses/pay", to: "statuses#pay"
  resources :statuses
  resources :categories do
    collection do
      post "import"
    end
  end
end

