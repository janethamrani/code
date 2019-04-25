class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show]
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
    @user_posts = @user.posts.all.order("created_at desc")
    @posts = Post.all.order("created_at desc")
  end

  def index
    @users = User.all.order("created_at desc")
    @posts_waiting = Post.all.waiting_for_approval
  end

  def edit
  end

  def new
    @user = User.new(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')
    @user.save
  end

  def create
    @user = User.new(user_params)
    @user.save

    if @user.save
      redirect_to @user, notice: "Your changes were successfully saved!"
    else
      render 'new', notice: "Oh no! Your changes were not able to be saved!"
    end
  end

  def update
    if @user.update user_params
      redirect_to @user, notice: "Your changes were saved!"
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user, :email, :full_name).permit(:editor, :admin, :slug)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
