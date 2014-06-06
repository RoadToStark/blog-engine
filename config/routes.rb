Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do

      resources :blogs do
        resources :articles,  only: [:index, :create]
      end

      resources :articles, only: [:index, :show, :update, :destroy]

    end
  end
end
