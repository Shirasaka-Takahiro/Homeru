Rails.application.routes.draw do

  get 'description_english/index'
  root to: 'reports#index'

  resources :reports do
    resource :favorites, only: [:create, :destroy]
    resources :comments
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :admin do
    resources :users
  end

  resources :users

  resources :descriptions

end
