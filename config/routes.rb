Rails.application.routes.draw do

  devise_for :users
  root 'recipes#index'
  get '/user/profile' => 'users#show'

  resources :recipes do
    resources :comments
  end

  resources :users do
    resources :recipes
  end

  # get '/auth/facebook/callback', to: 'sessions#auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
