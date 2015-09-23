require 'will_paginate/array'
class UsersController < ApplicationController
  before_action :find_user, only: [:show, :update]

  def index
    if params[:query].present?
     @users = User.search(params[:query])
    else
     @users = User.all
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      flash[:notice] = @user.errors.messages
      redirect_to root_path
    end
  end

  def show
    begin
      @posts = Post.reorder("created_at DESC").where(:user_id => @user.id).page(params[:page]).per_page(Post.num_per_page)
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

  def timeline
    @user = current_user
    @array = @user.following.map{|user| user.id}
    @array << @user.id
    @posts = Post.reorder("created_at DESC").where(:user_id => @array).page(params[:page]).per_page(Post.num_per_page)
    @post = Post.new
    render 'posts/index'
  end

  def autocomplete
   values = User.search(params[:query], autocomplete: false, limit: 10).map {|u| {username: u.username}}
   render json: values
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :bio, :image_src)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
