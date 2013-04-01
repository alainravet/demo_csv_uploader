class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :https_redirect


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
  def https_redirect
    if ENV["ENABLE_HTTPS"] == "yes"
      if request.ssl? && !use_https? || !request.ssl? && use_https?
        protocol = request.ssl? ? "http" : "https"
        flash.keep
        redirect_to protocol: "#{protocol}://", status: :moved_permanently
      end
    end
  end

  def use_https?
    true # Override in other controllers
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    session[:user_id] = nil
  end
  helper_method :current_user
end
