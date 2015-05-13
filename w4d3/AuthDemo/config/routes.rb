Rails.application.routes.draw do
  resource :user, only: [:create, :new, :show]
  resource :session, only: [:create, :destroy, :new] # Can only be one session per user
end
