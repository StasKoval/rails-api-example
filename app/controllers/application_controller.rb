class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :current_user, :current_ability

  rescue_from CanCan::AccessDenied do |exception|
    render json: {'message': exception.message}
  end

private

  def current_user
    @current_user ||= restrict_access if env['HTTP_AUTHORIZATION']
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
