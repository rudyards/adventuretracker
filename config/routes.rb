Rails.application.routes.draw do
  root 'home#index'
  get '/', to: 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  post '/register',  to: 'users#create'
  get '/create', to: 'games#new'
  post '/create', to: 'games#create'
  get '/delete', to: 'games#delete'
  get '/settings', to: 'users#update'



  resources :users
  resources :games
  resources :meetings

  
end
