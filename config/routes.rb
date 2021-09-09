Rails.application.routes.draw do
  resources :channel_counters, only: [:index]
  resources :channel_statistics, only: [:show, :index] do
    member do
      get :last_week
      get :today
      get :current
      get :current_sent
    end
  end
  resources :servers do
    member do
      patch :update_properties
    end
    resources :channels, only: [:index, :show, :destroy] do
      collection do
        post :fetch_all
      end
    end
    resources :channel_statistics, only: [:index, :show], module: :servers do
      collection do
        post :fetch_all
      end
    end
  end
  get 'home/index'

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'home#index'
  mount Wobauth::Engine, at: '/auth'
end
