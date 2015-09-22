Rails.application.routes.draw do

  root 'sessions#index'

  get '/signin', to: 'sessions#new', as: 'sign_in'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy', as: 'sign_out'

  post '/follow/:id', to: 'relationships#create'
  post '/unfollow/:id', to: 'relationships#destroy'

  # get '/users/search', to: 'users#search', as: 'search_user'

  get '/timeline', to: 'users#timeline', as: 'timeline'

  resources :users do
    collection do
      get :autocomplete
    end
  end

  resources :users
  resources :posts

  delete 'posts/:id', to: 'posts#destroy', as: 'destroy_post'
end
