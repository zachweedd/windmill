Rails.application.routes.draw do
  root to: 'configuration_groups#index'

  resources :clients
  resources :api_keys

  resources :client_configurations, only: [:new, :show, :edit, :update, :destroy]

  resources :configuration_groups do
    resources :client_configurations, only: [:index, :new, :create],
      controller: 'configuration_groups/client_configurations'
  end

  namespace :api do
    namespace :v1 do
      get :status, to: 'base_api#status'

      resource :client do
        post :enroll, to: 'clients/enrollment#create'
      end

      resources :clients do
        get :configuration, to: 'clients/configuration#show'
      end

      resources :client_configurations
      resources :configuration_groups
    end
  end

  devise_for :users
end
