class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user           = User.new(user_params)
    @user.username  = User.random_name
    @user.image_src = User.random_src

    if @user.save
      session[:user_id] = @user.id
    end
    redirect_to posts_path
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def search
    @users = User.search(params[:query])
    render 'search_results'
  end

  def timeline
    @user = current_user
    @posts = @user.timeline_posts
    render 'posts/index'
  end


  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
