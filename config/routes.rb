Rails.application.routes.draw do
  devise_for :admins
  
  devise_for :end_users
  
  namespace :admin do
    get '/' => 'homes#top', as: 'top'
    resources :comments, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
  end
  
  scope module: :public do
    root to: 'homes#top'
    get 'homes/top' => 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy]
    resources :end_users, only: [:show, :edit, :update]
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
