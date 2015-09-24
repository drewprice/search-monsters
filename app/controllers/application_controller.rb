class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :get_suggestions
  before_action :generate_suggestions

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  private

  def generate_suggestions
    current_user.suggest if user_signed_in?
  end
end
