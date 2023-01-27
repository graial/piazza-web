Rails.application.routes.draw do
  root 'feed#show'
  get 'home', to: 'home#index'
  get "sign_up", to: 'user#new'
  post "sign_up", to: 'user#create'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
