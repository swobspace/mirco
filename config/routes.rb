Rails.application.routes.draw do
  resources :servers do
    member do
      patch :update_properties
    end
    resources :channels, only: [:index, :show, :destroy] do
      collection do
        post :fetch
      end
    end
  end
  get 'home/index'

  get "/pages/index", to: 'pages#index'
  get "/pages/*page", to: 'pages#show', as: :page, format: false

  root to: 'home#index'
  mount Wobauth::Engine, at: '/auth'
end
