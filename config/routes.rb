Rails.application.routes.draw do
  resources :comments
  resources :stories
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
