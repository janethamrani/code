Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'


  resources :users
  devise_for :users, controllers: {:registrations => "users/registrations"}
  resources :posts
  resources :projects
  resources :contacts, only: [:new, :create]
  resources :applies, only: [:new, :create]

  devise_scope :user do
  get 'login', to: 'devise/sessions#new'
  get 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session_path
end

  get "/pages/:page" => "pages#show"
  get 'welcome/index'
  get 'topic-help' => 'pages#topic'


  root 'welcome#index'
  get '*path' => redirect('/')
end
