Rails.application.routes.draw do
<<<<<<< HEAD
  get 'users/show'
  # root 'foods#index'
  resources :categories
=======
  resources :stories
>>>>>>> food_stories
  resources :foods
  devise_for :users
  root 'welcome#index'
  
end
