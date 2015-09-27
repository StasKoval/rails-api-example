class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper_method :current_user, :current_ability

  rescue_from CanCan::AccessDenied do |exception|
    render json: {'message': exception.message}
  end

private

  def current_user
    unless ['index', 'show'].include?(params[:action])
      @current_user ||= restrict_access
    end
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      User.where(token: token).first
    end
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
end
