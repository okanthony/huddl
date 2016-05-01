class RegistrationsController < Devise::RegistrationsController

  protected

  def after_sign_up_path_for(_resource)
    selector_index_path
  end
end
