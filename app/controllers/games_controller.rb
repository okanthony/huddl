class GamesController < PermissionsController
  before_filter :require_permission, except: [:index]

  def index
    @games = Game.all.order(game_day: :asc)
  end

  def new
    @game = Game.new
    @states = Game::STATES
  end

  def create
    @game = Game.new(game_params)
    @states = Game::STATES
    if @game.save
      flash[:notice] = "Game Added"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join(". ")
      render :new
    end
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
      :opponent
    )
  end
end
