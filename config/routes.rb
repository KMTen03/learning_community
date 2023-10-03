Rails.application.routes.draw do
  devise_for :controllers
  namespace :public do
    get 'comments/create'
    get 'comments/destroy'
  end
  namespace :public do
    get 'likes/create'
    get 'likes/destroy'
  end
  namespace :public do
    get 'posts/new'
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/create'
    get 'posts/update'
    get 'posts/destroy'
  end
  namespace :admin do
    get 'comments/index'
    get 'comments/show'
    get 'comments/edit'
    get 'comments/update'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
    get 'posts/edit'
    get 'posts/update'
  end
  namespace :admin do
    get 'end_users/index'
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/update'
  end
  namespace :public do
    get 'end_users/show'
    get 'end_users/edit'
    get 'end_users/update'
    get 'end_users/withdraw'
  end
  devise_for :admins
  devise_for :end_users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
