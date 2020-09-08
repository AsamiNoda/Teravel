Rails.application.routes.draw do
  devise_for :users
  root "home#top"
  get "home/about" => "home#about"
  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    get 'follows' => 'relationships#follower', as: 'follows'
    get 'followers' => 'relationships#followed', as: 'followers'
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resource :post_comments, only: [:create, :destroy]
  end
  resources :tags do
    get 'posts', to: 'posts#search'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
