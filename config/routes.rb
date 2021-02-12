Rails.application.routes.draw do
  root "sessions#home"
  
  get '/signup' => 'users#new'
  post 'signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  delete '/logout' => 'sessions#destroy'

  match '/auth/:google_oauth2/callback' => 'sessions#google', via: [:get, :post]

  resources :wineries do
    resources :comments, only: [:new, :create, :index]
  end
  resources :comments
  resources :users do
    resources :wineries, only: [:new, :create, :index]
  end
  resources :regions do
    resources :wineries, only: [:new, :create, :index, :show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
