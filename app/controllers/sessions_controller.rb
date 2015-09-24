class SessionsController < ApplicationController
  def index
    redirect_to posts_path if user_signed_in?
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

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
