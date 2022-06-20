# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[edit update] do
    resources :comments, only: %i(create destroy)
    resource :likes, only: %i(create destroy)
  end
  resources :users, except: %i[index new edit]
  get '/current_user/edit', to: 'users#edit'
  get '/signup', to: 'users#new'
  get '/signin', to: 'sessions#new'
  delete '/signout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
