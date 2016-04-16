Rails.application.routes.draw do
  root to: 'configuration_groups#index'

  resources :configurations
  resources :clients
  resources :configuration_groups
  resources :api_keys

  namespace :api do
    get :status, to: 'api#status'
    post :enroll, to: 'api#enroll'
    post :config, to: 'api#config'
  end
end
