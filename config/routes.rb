Rails.application.routes.draw do

  root "sessions#new"
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  get    '/signup',    to: 'users#new'

  resources :users
  resources :account_activations, only: [:edit]

end
