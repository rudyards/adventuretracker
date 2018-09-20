Rails.application.routes.draw do
  root 'home#index'
  get '/', to: 'home#index'

  get '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'
  get '/register', to: 'users#new'
  post '/register',  to: 'users#create'
  get '/create', to: 'rpgs#create'
  get '/delete', to: 'rpgs#delete'



  resources :users
  resources :rpgs
  resources :meetings

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
