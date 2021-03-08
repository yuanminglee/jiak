Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users
  get 'profile', to: 'users#show', as: 'user_profile'

  resources :restaurants do
    resources :meals
  end

  resources :orders, except: :destroy do
    member do
      patch 'cancel'
      patch 'confirmed'
    end
    resources :line_items, except: :destroy
  end

  resources :line_items, only: :destroy
end
