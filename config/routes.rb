Rails.application.routes.draw do
  root to: 'configuration_groups#index'

  resources :clients
  resources :api_keys

  resources :client_configurations, only: [:show, :edit, :update, :destroy]

  resources :configuration_groups do
    resources :client_configurations, only: [:index, :new, :create],
      controller: 'configuration_groups/client_configurations'
  end

  namespace :api do
    get :status, to: 'api#status'
    post :enroll, to: 'api#enroll'
    post :config, to: 'api#config'
  end
end
