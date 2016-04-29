class UsersController < PermissionsController
  before_filter :require_permission
  
  def index
    @users = User.where(team: current_user.team)
  end
end
