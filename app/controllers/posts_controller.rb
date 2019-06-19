class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  load_and_authorize_resource





  def index
    if params[:category].blank?
      @posts = Post.approved.all.order("created_at desc")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.approved.where(category_id: @category_id).order("created_at DESC")

  end
  end





  def new
    if user_signed_in?
     @post = current_user.posts.build
   else
     @post = Post.new
   end
 end


 def create
   if user_signed_in?
     @post = current_user.posts.build(post_params)
   else
     @post = Post.new(post_params)
   end

   if @post.save && @post.approved
     redirect_to @post, notice: "Congrats! Your post was successfully published!"
   elsif @post.save
     redirect_to @post, notice: "Changes were successfully saved!"
   else
     render 'new', notice: "Oh no! Your post was not able to be saved!"
   end
 end

  def show

    redirect_to root_path unless (@post.approved || (current_user && (@post.user_id == current_user.id ||  current_user.admin?)))
    @users = User.all.order("created_at desc")
    set_meta_tags title: @post.title,
                  description: @post.meta_description,
                  keywords: @post.keywords


  end


  def edit
  end

  def update
    if @post.update post_params
      redirect_to @post, notice: "Your article was successfully saved!"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image, :slug, :category_id, :meta_description, :author, :waiting_for_approval, :approved)
  end
  def find_post
    @post = Post.friendly.find(params[:id])
  end
end
