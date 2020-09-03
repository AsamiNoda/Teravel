Rails.application.routes.draw do
  devise_for :users
  root "home#top"
  get "home/about" => "home#about"
  resources :users, expect: [:create] do
    resource :relationships, only: [:create, :destroy]
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
