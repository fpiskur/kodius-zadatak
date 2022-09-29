Rails.application.routes.draw do

  root "rooms#index"
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'
  get    '/signup',    to: 'users#new'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :rooms do
    resources :reservations,        only: [:create]
  end

  post 'messages/send_custom_message', to: 'messages#send_custom_message', as: 'message'

end
