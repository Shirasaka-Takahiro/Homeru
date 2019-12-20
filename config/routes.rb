Rails.application.routes.draw do

  get 'comments/create'
  get 'comments/destroy'
  root to: 'reports#index'

  resources :reports do
    resource :favorites, only: [:create, :destroy]
    resources :comments
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  namespace :admin do
    resources :users
  end

  resources :users

end
