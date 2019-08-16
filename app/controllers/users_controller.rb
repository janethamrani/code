class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  #before_action :authenticate_user!, only: [:show, :edit]
  #before_action :is_admin?, only: [:index]
  #load_and_authorize_resource




  def show
    @user = User.friendly.find(params[:id])
    @user_posts = @user.posts.all.order("created_at desc")
    @posts = Post.all.order("created_at desc")
  end

  def index
    @users = User.all.order("created_at desc")
  end

  def edit
  end

  def new
    @user = User.new
    @user.save

  end

  def create
    @user = User.new(user_params)
    @user.save

    if @user.save
      redirect_to root_path, notice: "Your changes were successfully saved!"
    else
      render 'new', notice: "Oh no! Your changes were not able to be saved!"
    end
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, notice: "Your changes were saved!"
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end
  def is_admin?
    redirect_to root_path unless (current_user && (current_user.admin?))
  end
  def should_generate_new_friendly_id?
     full_name_changed?
   end
  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :slug, :admin)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
