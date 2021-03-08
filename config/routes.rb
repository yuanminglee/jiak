Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  get 'profile', to: 'users#show', as: 'user_profile'

  resources :restaurants do
    resources :meals
    member do 
      get 'orders'
    end
  end

  resources :orders, except: :destroy do
    member do
      patch 'cancel'
      patch 'confirm'
    end
    resources :line_items, except: :destroy
  end

  resources :line_items, only: :destroy
end
