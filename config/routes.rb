Rails.application.routes.draw do

  root 'users#home'

  resources :recipes do
    resources :comments
  end

  resources :users, only: [:create, :show, :edit, :update, :destroy] do
    resources :recipes
  end

  get 'recipes/ingredients/new', to: 'ingredients#new'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  get 'signout', to: 'sessions#destroy'

  # get '/auth/facebook/callback', to: 'sessions#auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
