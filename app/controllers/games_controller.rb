class GamesController < PermissionsController
  before_filter :require_permission, except: [:index, :show]

  def index
    @team = current_user.team
    @games = Game.all.order(game_day: :asc)
    @access = current_user.try(:admin?)
  end

  def new
    @game = Game.new
    @states = Game::STATES
  end

  def create
    @team = current_user.team
    @game = Game.new(game_params)
    @game.team = @team
    @states = Game::STATES
    if @game.save
      @game.text("created", @game, true)
      flash[:notice] = "Game Added"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @game = Game.find(params[:id])
    @states = Game::STATES
  end

  def update
    @game = Game.find(params[:id])
    @states = Game::STATES
    if @game.update(game_params)
      @game.text("edited", @game, true)
      flash[:notice] = "Game Updated"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join('. ')
      render :edit
    end
  end

  def show
    @game = Game.find(params[:id])
    @roster = Confirmation.where(game: @game, rsvp: true).order(updated_at: :asc)
    @current_user_status = Confirmation.where(game: @game, user: current_user)
    if @current_user_status.empty? || @current_user_status.first.rsvp == false
      @button_text = "Claim"
    else
      @button_text = "Relinquish"
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    @game.text("deleted", @game, false)
    flash[:notice] = "Game Deleted"
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(
      :street,
      :city,
      :state,
      :zip,
      :game_day,
      :game_time,
      :opponent,
      :latitude,
      :longitude
    )
  end
end
