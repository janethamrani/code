class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  def index
    if params[:category].blank?
      @posts = Post.all.order("created_at desc")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(category_id: @category_id).order("created_at DESC")

  end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Your article was successfully saved!"
    else
      render "new", notice: "Your post wasn't saved"
    end
  end


  def show

    set_meta_tags    title: @post.title,
                     description: @post.meta_description


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
    params.require(:post).permit(:title, :content, :image, :slug, :category_id, :meta_description, :author)
  end
  def find_post
    @post = Post.friendly.find(params[:id])
  end
end
