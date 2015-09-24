Rails.application.routes.draw do
  root 'sessions#index'

  get '/signin', to: 'sessions#new', as: 'sign_in'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'sign_out'

  post '/follow/:id', to: 'relationships#create'
  post '/unfollow/:id', to: 'relationships#destroy'

  get '/timeline', to: 'users#timeline', as: 'timeline'

  resources :users do
    collection do
      get :autocomplete
    end
  end

  post 'user/:id', to: 'users#update'
  resources :users
  resources :posts
  get 'users/:id/followers', to: 'users#followers', as: 'user_followers'
  get 'users/:id/following', to: 'users#following', as: 'user_following'
  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'
end
