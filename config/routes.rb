Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'

  resources :users
  devise_for :users, controllers: {:registrations => "users/registrations"}
  resources :posts
  resources :projects
  resources :contacts, only: [:new, :create]
  resources :applies, only: [:new, :create]

  get 'welcome/index'
  root 'welcome#index'
  get '*path' => redirect('/')
end
