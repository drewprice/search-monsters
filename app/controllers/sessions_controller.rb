require 'will_paginate/array'

class SessionsController < ApplicationController

  def index
    @posts = Post.all_for(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      @user.suggest
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = 'Your email or password was incorrect. Please try again.'
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
