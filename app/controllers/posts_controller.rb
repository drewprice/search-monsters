class PostsController < ApplicationController
  before_action :assign_post, only: [:edit, :destroy, :update]

  def index
    if user_signed_in?
      @posts = Post.all_for(params[:page])
      @timeline_posts = current_user.timeline_posts(params[:page])
    else
      redirect_to sign_in_path
    end
  end

  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.js { render 'posts/create' }
      else
        format.js { render 'posts/error' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        PrivatePub.publish_to('/live-feed', message: @post)
        format.json { render json: @post }
      else
        format.json { render js: 'alert("Try again!");' }
      end
    end
  end

  def destroy
    render js: 'alert("Try again!");' unless @post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end

  def assign_post
    @post = Post.find(params[:id])
  end
end
