class UsersController < ApplicationController
  before_action :find_user, only: [:show, :update]

  def new
    @user = User.new
  end

  def create
    @user           = User.new(user_params)
    @user.username  = User.random_name
    @user.image_src = User.random_src

    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render 'sessions/index', alert: 'Something went wrong... try again!'
    end
  end

  def show
    begin
      @posts = @user.posts
    rescue
      flash[:notice] = "Sorry, that user does not exist!"
      redirect_to root_path
    end
  end

  def update
    @user.update(user_params)

    respond_to do |format|
      format.json { render json: @user }
    end
  end

  def search
    @users = User.search(params[:query])
    render 'search_results'
  end

  def timeline
    @user = current_user
    @posts = @user.timeline_posts
    @post = Post.new
    render 'posts/index'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :bio, :image_src)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
