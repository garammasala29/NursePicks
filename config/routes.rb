Rails.application.routes.draw do
  root 'posts#index'
  resources :posts, except: %i(edit update)
  resources :users, except: :index
end
