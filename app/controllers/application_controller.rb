class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    custom_keys = [:username, :name, :email, :password, :password_confirmation, :location, :avatar, :bio]
    devise_parameter_sanitizer.permit(:sign_up, keys: custom_keys)
  end
end
