Rails.application.routes.draw do

  resources :users
  root 'posts#index'
  resources :posts
  delete '/logout', to: "sessions#destroy", as: "logout"
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'

end
