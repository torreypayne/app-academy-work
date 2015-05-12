Rails.application.routes.draw do
  # resources :users
  root to: 'users#index'

  get '/users/' => 'users#index'
  post '/users/' => 'users#create'
  get '/users/new/' => 'users#show', :as => 'new_user'
  get '/users/:id/edit' => 'users#edit', :as => 'edit_user'
  get '/users/:id' => 'users#show', as: 'user'
  patch '/users/:id' => 'users#update', as: 'update_user'
  put '/users/:id' => 'users#update'
  delete '/users/:id' => 'users#destroy', as: 'delete_user'






end
