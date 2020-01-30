class ApplicationController < ActionController::API
  protect_from_forgery with: :exception
  helper_method :current_user
  include Response

  rescue_from ActiveRecord::RecordNotFound do |exception|
    json_response({ message: exception.message }, :not_found)
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end

  def authorize
    if !current_user
      flash[:alert] = "You aren't authorized to visit that page."
      redirect_to '/'
    end
  end

  def admin_only
    if current_user.admin === false
      flash[:alert] = "You must be an admin to view or edit this page!"
      redirect_to '/'
    end
  end
end
