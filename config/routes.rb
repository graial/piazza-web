Rails.application.routes.draw do
  root 'feed#show'
  get 'home', to: 'home#index'
  get "sign_up", to: 'user#new'
  post "sign_up", to: 'user#create'

  get "login", to: 'sessions#new'
  post "login", to: 'sessions#create'
  delete "logout", to: 'sessions#destroy'
 
  resource :profile, only: [:show, :update],
    controller: "user"
end
