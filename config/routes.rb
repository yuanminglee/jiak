Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users

  get 'profile', to: 'users#show', as: 'user_profile'

  resources :restaurants do
    resources :meals
  end

  resources :orders do
    resources :line_items
  end
end
