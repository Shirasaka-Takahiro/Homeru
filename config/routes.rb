Rails.application.routes.draw do

  root to: 'reports#index'

  resources :reports do
    resource :favorites, only: [:create, :destroy]
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
