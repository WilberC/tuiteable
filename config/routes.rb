Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tuits#index"
  resources :users, only: :show
  get '/user_like/:id', to: 'users#show_likes'
  resources :tuits, only: [:index, :show]
  namespace :api do
    resources :tuits, only: [:index, :show, :create, :update, :destroy]
    resources :users, only: [] do
      resources :tuits, only: [:index, :show, :create, :update, :destroy]
      get '/followers', to: 'follows#show'
      get '/followings', to: 'follows#show'
      get '/follow', to: 'follows#create'
      get '/follow', to: 'follows#destroy'
    end
    resources :tuits, only: [] do
      resources :comments, only: [:index, :show, :create, :update, :destroy]
    end
    resources :tuits, only: [] do
      resources :likes, only: [:index, :create, :destroy]
    end
  end
end
