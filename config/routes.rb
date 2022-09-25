Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'

  root "rooms#index"
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  get    '/signup',    to: 'users#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :rooms

end
