Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tuits#index"
  resources :tuits, only: [:index, :show]
  namespace :api do
    namespace :sessions do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
      end
    end
    resources :users, only: [:create] do
      resources :tuits, only: [:index, :show]
      get '/followers', to: 'follows#show'
      get '/followings', to: 'follows#show'
      get '/follow', to: 'follows#create'
      get '/follow', to: 'follows#destroy'
    end
    resources :tuits, only: [:create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create, :update, :destroy]
      resources :likes, only: [:index, :create, :destroy]
    end
  end
  
end
