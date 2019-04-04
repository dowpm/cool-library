Rails.application.routes.draw do
  root 'home#index'
  resources :reviews
  resources :users, only: [:show] do
    resources :books, except: [:destroy]
  end
  resources :books
  get '/signup', to: 'users#new'
  post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/auth/facebook/callback', to: 'sessions#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
