Rails.application.routes.draw do


  root 'homes#top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts do
  	resource :favorites,only: [:create, :destroy]
  	resources :post_comments, only: [:create, :destroy]
  end

  resources :users
  get 'search' => 'searches#search'

  post 'follow/:id' => 'relationships#follow', as:'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as:'unfollow'

  get 'followerindex/:id' => 'users#followerindex', as:"followerindex"
  get 'followedindex/:id' => 'users#followedindex', as:"followedindex"

end