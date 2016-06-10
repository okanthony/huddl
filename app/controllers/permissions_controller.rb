class PermissionsController < HelperController
  def require_permission
    session[:current_page] ||= request.referer
    unless current_user.try(:admin?)
      flash[:alert] = "Sorry, You Do Not Have Permission To Complete This Action"
      redirect_to unauthenticated_root_path
    end
  end
end
