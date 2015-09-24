class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from CanCan::AccessDenied { restrict_access }

private

  def restrict_access
    # authenticate_or_request_with_http_basic do |username, password|
    #   username == "foo" && password == "bar"
    # end
    # render json: {message: 'Unauthorized: Access is denied due to invalid credentials'}, status: :unauthorized
  end
end
