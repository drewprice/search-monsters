Rails.application.routes.draw do

  root 'posts#index'

  get '/signin', to: 'sessions#new', as: 'sign_in'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'sign_out'

  resources :users

  resources :posts
  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'
end
