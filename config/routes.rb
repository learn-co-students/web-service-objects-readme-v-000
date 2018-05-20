Rails.application.routes.draw do
  root 'searches#index'
  get '/search', to: 'searches#index'
  post '/search', to: 'searches#search'

  get '/auth', to: 'sessions#create'
  get '/friends', to: 'searches#friends'

  resources :tips, only: [:index, :create]
end
