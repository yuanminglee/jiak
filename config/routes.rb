Rails.application.routes.draw do
  root to: 'pages#home'
  get "/learnmore", to: "pages#learn_more"

  devise_for :users
  get 'profile', to: 'users#show', as: 'user_profile'
  get 'earnings', to: 'users#earnings', as: 'user_earnings'

  resources :restaurants do
    resources :meals
    member do
      get 'orders'
    end
  end

  resources :orders, except: :destroy do
    member do
      patch 'cancel'
      get 'success'
      get 'collect_order'
      patch 'update_collect_order'

    end
    resources :line_items, except: :destroy
    resources :payments, only: :new
  end



  resources :line_items, only: :destroy

  mount StripeEvent::Engine, at: '/stripe-webhooks'
end
