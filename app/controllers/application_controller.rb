class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Allow extra params for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Permit extra fields (name and role) during sign up and account update
  def configure_permitted_parameters
    # For sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])

    # For account update
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
