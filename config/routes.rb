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
    resources :comments, except: %w[new]
    resources :posts, except: %w[new]
    resources :end_users, except: %w[new create destroy]
    resources :tags, except: %w[new show]
  end

  scope module: :publics do
    root to: 'posts#index'
    get 'search' => 'searches#search'
    
    resources :posts do
      resources :comments, only: %w[create destroy]
      resource :likes, only: %w[create destroy]
    end

    resources :end_users, only: [:show, :edit, :update] do
      member do
        get :confirm
        patch :withdraw
        get :likes
      end
    end

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
