class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :get_suggestions

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !!current_user
  end

  def get_suggestions
    suggestions_array ||= Suggestion.new(current_user) if session[:user_id]
  end
end
