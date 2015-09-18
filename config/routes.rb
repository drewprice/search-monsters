Rails.application.routes.draw do

  root 'posts#index'
  resources :posts
  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'
end
