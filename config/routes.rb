# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[edit update]
  resources :posts do
    resources :comments, only: %i(create destroy)
  end
  resources :users, except: :index
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
