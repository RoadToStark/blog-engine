Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :blogs do
        resources :articles,  only: [:index, :create]
      end

      resources :articles, only: [:index, :show, :update, :destroy] do
        resources :comments, only: [:index, :create]
      end

      resources :comments, only: [:index, :show, :update, :destroy]

      resources :users do
        resources :blogs, only: [:index]
        resources :articles, only: [:index]
        resources :comments, only: [:index]
      end

      # Login routes
      post "login" => "sessions#create", :as => "login"
      get "logout" => "sessions#destroy", :as => "logout"
    end
  end
end
