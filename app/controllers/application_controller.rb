class ApplicationController < ActionController::Base
  # Disable CSRF protection
  skip_before_action :verify_authenticity_token

  # JSON is needed so that consumers can get info for the current user.
  respond_to :html, :json

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || '/'
  end

  protected

  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end
end
