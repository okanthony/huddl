class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
   devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :phone]
   devise_parameter_sanitizer.for(:account_update) << [:email, :password, :password_confirmation, :remember_me, :phone]
  end
end
