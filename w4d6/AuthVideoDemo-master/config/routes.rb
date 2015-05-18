AuthDemo::Application.routes.draw do
  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/contact"
  post "static_pages/contact"
  resource :session, only: [:create, :destroy, :new]
  resource :user, only: [:create, :new, :show] do
    resource :counter, only: [:update]
  end
  resources :static_pages, only: [:home, :contact, :about]
end
