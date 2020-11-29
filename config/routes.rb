Rails.application.routes.draw do
  # root 'foods#index'
  resources :categories
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
