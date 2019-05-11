Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users,
  :skip => [:registrations, :sessions]
  as User do
  # Registrations
  get   '/signup'   => 'users/registrations#new', as: :new_user_registration
  post  '/signup'   => 'users/registrations#create', as: :user_registration

end
  #devise_for :users, controllers: {:registrations => "users/registrations"}
  resources :users
  resources :posts
  resources :projects
  resources :contacts, only: [:new, :create]
  resources :applies, only: [:new, :create]

  get 'welcome/index'
  root 'welcome#index'
  get '*path' => redirect('/')
end
