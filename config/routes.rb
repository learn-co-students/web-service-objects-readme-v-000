Rails.application.routes.draw do
  root 'searches#search'
  get '/search', to: 'searches#search'
  post '/search', to: 'searches#find'

  get '/auth', to: 'sessions#create'
  get '/friends', to: 'searches#friends'

  resources :tips, only: [:index, :create]
end
