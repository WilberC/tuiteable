Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tuits#index"
  resources :users, only: :show
  get '/user_like/:id', to: 'users#show_likes'
  post '/create_tuit', to: 'tuits#create_tuit'
  get '/delete_tuit/:id', to: 'tuits#delete_tuit'
  resources :tuits, only: [:index, :show]
  namespace :api do
    namespace :sessions do
      devise_scope :user do
        post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        put "log_out", to: "sessions#update"
      end
    end
    resources :users, only: [:create] do
      resources :tuits, only: [:index, :show]
      get '/followers', to: 'follows#show'
      get '/followings', to: 'follows#show'
      post '/follow', to: 'follows#create'
      delete '/follow', to: 'follows#destroy'
    end
    resources :tuits, only: [:create, :update, :destroy] do
      resources :comments, only: [:index, :show, :create, :update, :destroy]
      resources :likes, only: [:index, :create]
      delete '/likes', to: 'likes#destroy'
    end
  end
end
