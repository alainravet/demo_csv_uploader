class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    unless current_user.present?
      redirect_to log_in_path, alert: "Not authorized : you must login first"
    end
  end

  def authorize_admin_only
    unless current_user.try(:admin?)
      redirect_to log_in_path, alert: "Not authorized : ADMIN only"
    end
  end

  def authorize_owner_or_admin_only
    unless current_user && (current_user.admin? || current_user == @user)
      redirect_to log_in_path, alert: "Not authorized"
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
