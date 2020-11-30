Rails.application.routes.draw do
  get 'users/show'
  # root 'foods#index'
  # resources :categories
  resources :stories
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
