class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    # binding.pry
    @post = Post.new(post_params)
    @post.save
    # redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end
