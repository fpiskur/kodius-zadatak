Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  
  root "users#new"
  
end
