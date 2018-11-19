Rails.application.routes.draw do
  root 'home#index'
  get '/', to: 'home#index'

  resources :users

  # post '/create', to: 'games#create'
  get '/games/:id/confirm', to: 'games#confirm', as: :confirm_game
  get '/games/new',      to: 'games#new',  as: :new_game
  post '/games/create',  to: 'games#create', as: :create_game
  resources :games
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'



  resources :meetings

  
end
