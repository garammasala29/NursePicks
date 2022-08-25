# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i[new edit update] do
    resources :comments, only: %i(create destroy)
    resource :likes, only: %i(create destroy)
  end
  resources :users, except: %i[index new edit]
  get '/current_user/edit', to: 'users#edit'
  get '/signup', to: 'users#new'
  delete '/signout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  namespace :api do
    resources :posts, only: %i(index destroy) do
      resources :likes, only: %i(create destroy)
      resources :comments, only: %i(destroy)
    end
    resources :users, only: %i(show)
  end

  get 'tos', to: 'home#tos', as: 'tos'
  get 'privacy_policy', to: 'home#privacy_policy'
end
