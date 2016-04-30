class UsersController < PermissionsController
  before_filter :require_permission

  def index
    @users = User.where(team: current_user.team)
    @invitee = User.new
  end

  def invite
    # @invitee = User.new(user_params)
    # if @invitee.errors.nil?
    #   @invitee = User.invite!(user_params)
    #   flash[:notice] = "Player Invited"
    #   redirect_to users_path
    # else
    #   flash[:alert] = @invitee.errors.full_messages.join(". ")
    #   render :index
    # end
    @invitee = User.invite!(user_params)
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
