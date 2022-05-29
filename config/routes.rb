# frozen_string_literal: true

Rails.application.routes.draw do
  resources :interface_connectors
  resources :software_interfaces
  resources :software
  resources :locations
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
end
