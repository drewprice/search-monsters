class SessionsController < ApplicationController

  def index

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])

    if @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
    end

    redirect_to posts_path
  end
end
