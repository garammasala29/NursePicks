Rails.application.routes.draw do
  get 'users/new'
  get 'users/show'
  get 'users/edit'
  root 'posts#index'
  resources :posts, except: %i(edit update)
end
