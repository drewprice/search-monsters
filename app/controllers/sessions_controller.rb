class SessionsController < ApplicationController

  def new
    @user = User.new

    respond_to do |format|
      format.html
      format.js
    end
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
