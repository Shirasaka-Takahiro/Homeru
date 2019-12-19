Rails.application.routes.draw do

  root to: 'reports#index'

  resources :reports
  resources :favorites, only: [:create, :destroy]

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: "users/sessions",
  }

  namespace :admin do
    resources :users
  end

  resources :users do
    member do
      get :likes
    end
  end

end
