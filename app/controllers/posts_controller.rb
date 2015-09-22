class PostsController < ApplicationController
  before_action :assign_post, only: [:edit, :destroy, :update]

  def index
    @post = Post.new
    @posts = Post.all
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.js
      else
        format.js { render 'posts/error' }
      end
    end
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
    params.require(:post).permit(:body)
  end

  def assign_post
    @post = Post.find(params[:id])
  end
end
