# frozen_string_literal: true

Rails.application.routes.draw do
  resources :hosts do
    resources :software_interfaces, module: :hosts
  end
  resources :software_groups do
    resources :hosts, module: :software_groups
    resources :software, module: :software_groups
  end
  resources :software_connections do
    collection do
      get :search
    end
  end
  resources :interface_connectors do
    resources :software_connections, only: %i[index update], module: :interface_connectors
  end
  resources :software_interfaces do
    resources :interface_connectors, module: :software_interfaces
  end
  resources :software do
    resources :software_interfaces, module: :software
  end
  resources :locations do
    resources :hosts, module: :locations
  end
  resources :alerts, only: %i[index show]
  resources :channel_counters, only: [:index]
  resources :channel_statistics, only: %i[show index] do
    member do
      get :last_week
      get :last_month
      get :today
      get :current
      get :current_sent
    end
    resources :alerts, only: %i[index show], module: :channel_statistics
    resources :notes, module: :channel_statistics
  end
  resources :channels, only: %i[index show destroy] do
    resources :alerts, only: %i[index show], module: :channels
    resources :notes, module: :channels
  end
  resources :servers do
    member do
      post :update_properties
    end
    resources :server_configurations, only: %i[index show new create destroy]
    resources :alerts, only: %i[index show], module: :servers
    resources :notes, module: :servers
    resources :channels, only: %i[index destroy], module: :servers do
      collection do
        post :fetch_all
      end
      resources :alerts, only: %i[index show], module: :channels
    end
    resources :channel_statistics, only: %i[index show], module: :servers do
      collection do
        post :fetch_all
      end
    end
  end
  get 'home/index'

  get '/pages/index', to: 'pages#index'
  get '/pages/*page', to: 'pages#show', as: :page, format: false

  root to: 'home#index'
  mount Wobauth::Engine, at: '/auth'
  authenticate :user, ->(user) { user.is_admin? } do
    mount GoodJob::Engine => "good_job"
  end

end
