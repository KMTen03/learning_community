Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :end_users, controllers: {
    registrations: "publics/registrations",
    sessions: 'publics/sessions',
    passwords: 'users/passwords'
  }
  
  devise_scope :end_user do
    post 'end_users/guest_sign_in', to: 'publics/sessions#guest_sign_in'
  end

  namespace :admins do
    get '/' => 'homes#top', as: 'top'
    resources :comments, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
    resources :end_users, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :create, :edit, :update, :destroy]
  end

  scope module: :publics do
    root to: 'posts#index'
    get 'search' => 'searches#search'
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    get 'end_users/:id/confirm' => 'end_users#confirm', as: 'confirm'
    patch 'end_users/:id/withdraw' => 'end_users#withdraw', as: 'withdraw'

    resources :end_users, only: [:show, :edit, :update] do
      member do
        get :likes
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
