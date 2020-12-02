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
  
  get '/filter_stories_category', to: 'filters#filter_story_category', as: 'filter_story_category'
  get '/filter_stories_food', to: 'filters#filter_story_food', as: 'filter_story_food'

end
