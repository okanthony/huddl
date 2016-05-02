class UsersController < PermissionsController
  before_filter :require_permission

  def index
    @confirmed_users = User.where(team: current_user.team, admin: false).where("sign_in_count > '0'")
    @pending_users = User.where(team: current_user.team).where("sign_in_count = '0'")
    @invitee = User.new
  end

  def invite
    @invitee = User.new(user_params)
    if !@invitee.valid?
      flash[:alert] = @invitee.errors.full_messages.join(". ")
      @invitee.delete
      redirect_to users_path
    else
      @invitee.delete
      @invitee = User.invite!(user_params)
      flash[:notice] = "Player Invited"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
    ).merge(team: current_user.team, password: "passwordholder")
  end
end
