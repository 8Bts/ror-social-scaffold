Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users


  resources :friendships, only: [:create, :update, :destroy]

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

end
