Rails.application.routes.draw do
  root 'posts#index'

  get '/sign-in', to: 'sessions#new', as: 'sign_in'
  post '/sign-in', to: 'sessions#create'
  delete '/sign-out', to: 'sessions#destroy', as: 'sign_out'

  post '/follow/:id', to: 'relationships#create'
  post '/unfollow/:id', to: 'relationships#destroy'

  get '/timeline', to: 'users#timeline', as: 'timeline'

  resources :users do
    collection do
      get :autocomplete
    end
  end

  resources :users
  resources :posts
  get 'users/:id/followers', to: 'users#followers', as: 'user_followers'
  get 'users/:id/following', to: 'users#following', as: 'user_following'
end
