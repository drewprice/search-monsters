class PostsController < ApplicationController
  before_action :assign_post, only: [:edit, :destroy, :update]

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    @post.save
  end

  def edit
  end

  def update
    @post.update(post_params)
  end


  def destroy
    @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:body).merge(user_id: session[:user_id])
  end

  def assign_post
    @post = Post.find(params[:id])
  end
end
