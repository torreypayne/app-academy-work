Rails.application.routes.draw do
  get 'comments/new'

  get 'posts/new'

  get 'posts/edit'

  get 'posts/show'

  root to: 'users#index'
  resources :users
  resource :session
  resources :subs, only: [:create, :new, :index, :edit, :show, :update]
  resources :posts, only: [:create, :new, :edit, :show, :update] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]

end
