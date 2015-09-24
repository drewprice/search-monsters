class UsersController < ApplicationController
  before_action :find_user, only: [:show, :update, :edit, :followers, :following]

  def index
    if params[:query].present?
      @users = User.search(params[:query])
    else
      @users = User.all
    end
  end

  def show
    @posts = Post.reorder('created_at DESC').where(user_id: @user.id).page(params[:page]).per_page(Post::POSTS_PER_PAGE)
  rescue
    flash[:notice] = 'Sorry, that user does not exist!'
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
    else
      if @user.errors.messages == {:password=>["can't be blank"]}
        flash[:notice] = "Please enter a password."
      elsif @user.errors.messages == {:email=>["has already been taken"]}
        flash[:notice] = "That email has already been taken."
      else
        flash[:notice] = @user.errors.messages
      end
    end
    redirect_to root_path
  end

  def update
    @user.update(user_params)

    respond_to do |format|
      format.js
      format.json { render json: @user }
    end
  end

  def timeline
    # TODO: refactor
    if current_user
      @user = current_user
      @array = @user.following.map(&:id)
      @array << @user.id
      @posts = Post.reorder('created_at DESC').where(user_id: @array).page(params[:page]).per_page(Post::POSTS_PER_PAGE)
      render 'sessions/index'
    else
      redirect_to root_path
    end
  end

  def autocomplete
    values = User.search(params[:query], autocomplete: false, limit: 10).map { |u| { username: u.username } }
    render json: values
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :bio, :avatar)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
