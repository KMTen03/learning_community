Rails.application.routes.draw do

  devise_for :admins, controllers: {
        sessions: 'admins/sessions'
      }
      
  devise_for :end_users, controllers: {
        sessions: 'publics/sessions',
        registrations: "publics/registrations"
      }
      
  namespace :admins do
    get '/' => 'homes#top', as: 'top'
    resources :comments, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :end_users, only: [:index, :show, :edit, :update]
  end

  scope module: :publics do
    root to: 'homes#top'
    get 'homes/top' => 'homes#top'
    get 'homes/about' => 'homes#about', as: 'about'
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      
      resource :comments, only: [:create, :destroy]
      resource :likes, only: [:create, :destroy]
    end
    resources :end_users, only: [:show, :edit, :update]
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
