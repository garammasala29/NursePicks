Rails.application.routes.draw do
  get 'sessions/new'
  root 'posts#index'
  resources :posts, except: %i(edit update)
  resources :users, except: :index
end
