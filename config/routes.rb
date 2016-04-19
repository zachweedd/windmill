Rails.application.routes.draw do
  root to: 'configuration_groups#index'

  resources :clients
  resources :api_keys
  resources :configuration_groups do
    resources :client_configurations, controller: 'configuration_groups/configurations'
  end

  namespace :api do
    get :status, to: 'api#status'
    post :enroll, to: 'api#enroll'
    post :config, to: 'api#config'
  end
end
