# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[edit update]
  resources :users, except: :index
  delete '/signout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
