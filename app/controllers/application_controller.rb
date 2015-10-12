class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?
  before_action :generate_suggestions

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def authenticate_user
    return if user_signed_in?
    redirect_to sign_in_path, alert: "You must be logged in to do that!"
  end

  def generate_suggestions
    current_user.suggest if user_signed_in?
  end
end
