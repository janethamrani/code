class ApplicationController < ActionController::Base
  def index
    @posts_new = Post.all.limit(1).order("created_at desc")
   end
end
