class SessionsController < ApplicationController

  def index
    if user_signed_in?
      redirect_to posts_path
    end
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

    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      redirect_to root_path, alert: 'Something was not correct. Do it again, yo.'
    end
  end
end
