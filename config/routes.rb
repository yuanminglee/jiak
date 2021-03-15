Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  get 'profile', to: 'users#show', as: 'user_profile'

  resources :restaurants do
    resources :meals
    member do
      get 'orders'
    end
    collection do
      get 'owned'
    end
  end

  resources :orders, except: :destroy do
    member do
      patch 'cancel'
    end
    resources :line_items, except: :destroy
    resources :payments, only: :new
  end

  resources :line_items, only: :destroy

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
