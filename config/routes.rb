Rails.application.routes.draw do
  devise_for :admins
  mount Ckeditor::Engine => '/ckeditor'
  #devise_for :users,
  #:skip => [:registrations, :sessions]
  #devise_for :users, controllers: {:registrations => "users/registrations"}
  #resources :users, :controller => "users", :only => [:show, :edit, :update ]

  as User do
  # Registrations
  #get   '/signup'   => 'users/registrations#new', as: :new_user_registration
  #post  '/signup'   => 'users/registrations#create', as: :user_registration

end
#devise_for :users, skip: [:sessions], controllers: {:registrations => "users/registrations"}
#as :user do
#  get 'signin', to: 'devise/sessions#new', as: :new_user_session
#  post 'signin', to: 'devise/sessions#create', as: :user_session
#  delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
#end
#devise_scope :user do
#delete "/users/sign_out" => "devise/sessions#destroy"
#delete "/users/sign_in" => "devise/sessions#new"
#end
  #devise_for :users, controllers: {:registrations => "users/registrations"}
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
