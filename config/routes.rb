Rails.application.routes.draw do
  resources :stories
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
