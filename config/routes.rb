Rails.application.routes.draw do
  resources :categories
  get 'users/show'
  # root 'foods#index'
  # resources :categories
  resources :stories do
    resources :comments
  end
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
