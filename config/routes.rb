Rails.application.routes.draw do
  resources :comments
  resources :users
  resources :wineries
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
