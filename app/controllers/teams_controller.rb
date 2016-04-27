class TeamsController < ApplicationController
  def create
    @team = Team.new(team_params)
    @sports = Team::SPORTS
    if @team.save
      current_user.admin = true
      current_user.team = @team
      current_user.save
      flash[:notice] = "#{@team.name} Now Active!"
      redirect_to home_path
    else
      flash[:alert] = @team.errors.full_messages.join(". ")
      render 'selector/index'
    end
  end

  private

  def team_params
    params.require(:team).permit(
      :name,
      :sport
    )
  end
end
