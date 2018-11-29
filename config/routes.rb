Rails.application.routes.draw do
  root 'home#index'
  get '/', to: 'home#index'
  get '/about', to:'about#show'

  resources :users

  get '/games/:id/confirm',       to: 'games#confirm',     as: :confirm_game
  get '/games/new',               to: 'games#new',         as: :new_game
  post '/games/create',           to: 'games#create',      as: :create_game
  post '/games/:id/join',         to: 'games#knock',       as: :join_game
  post '/games/accept/:knockid',  to: 'games#knockaccept', as: :knock_accept_game
  post '/games/reject/:knockid',  to: 'games#knockreject', as: :knock_reject_game
  post '/games/:id/leave',        to: 'games#leave',       as: :leave_game
  post '/games/:id/kick/:userid', to: 'games#kick',        as: :kick_game
  resources :games
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'


  get '/meetings/new/:game_id',    to: 'meetings#new',       as: :new_meeting
  resources :meetings

  resources :memberships

  resources :knocks

  
end
