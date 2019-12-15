Rails.application.routes.draw do
  root to: 'reports#index'

  get 'reports/show'
  get 'reports/index'
  get 'reports/edit'
  get 'reports/update'
  get 'reports/create'
  get 'reports/destroy'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
