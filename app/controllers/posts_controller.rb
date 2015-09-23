class PostsController < ApplicationController
  before_action :assign_post, only: [:edit, :destroy, :update]

  def index
    @post = Post.new
    @posts = Post.reorder("created_at DESC").page(params[:page]).per_page(Post.num_per_page)
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      if @post.save
        format.js {render 'posts/create'}
      else
        format.js { render 'posts/error' }
      end
    end
  end

  def edit
  end

  def update
    @post.update(post_params)

    PrivatePub.publish_to('/live-feed', message: @post)

    respond_to do |format|
      format.json { render json: @post }
    end
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
