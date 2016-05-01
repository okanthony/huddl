class UsersController < PermissionsController
  before_filter :require_permission

  def index
    @confirmed_users = User.where(team: current_user.team, admin: false).where("sign_in_count > '0'")
    @pending_users = User.where(team: current_user.team).where("sign_in_count = '0'")
    @invitee = User.new
  end

  def invite
    # if
    #   @invitee = User.invite!(user_params)
    #   flash[:notice] = "Player Invited"
    #   redirect_to users_path
    # else
    #   flash[:alert] = @invitee.errors.full_messages.join(". ")
    #   render :index
    # end
    @invitee = User.invite!(user_params)
    flash[:notice] = "Player Invited"
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
    ).merge(team: current_user.team)
  end
end
