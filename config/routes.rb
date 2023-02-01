Rails.application.routes.draw do
  root 'feed#show'
  get 'home', to: 'home#index'
  get "sign_up", to: 'users#new'
  post "sign_up", to: 'users#create'

  get "login", to: 'sessions#new'
  post "login", to: 'sessions#create'
  delete "logout", to: 'sessions#destroy'
 
  namespace :users do 
    patch "change_password", to: "passwords#update"
    resources :password_resets, only: [:new, :create, :edit, :update]
  end
  
  resource :profile, only: [:show, :update],
    controller: "users"

  resources :listings, except: :index do
    scope module: :listings do
      post :draft, to: "drafts#create", on: :collection
      patch :draft, to: "drafts#update"
    end
  end

  resource :my_listings, only: :show
end
