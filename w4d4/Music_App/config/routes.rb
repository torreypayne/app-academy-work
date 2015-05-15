Rails.application.routes.draw do
  resources :users
  resource :session
  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy]
  resources :tracks
  resources :notes
end
