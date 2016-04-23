class GamesController < PermissionsController
  before_filter :require_permission, except: [:index]

  def index
    @games = Game.all.order(game_day: :asc)
    @access = current_user.try(:admin?)
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

  def edit
    @game = Game.find(params[:id])
    @states = Game::STATES
  end

  def update
    @game = Game.find(params[:id])
    @states = Game::STATES
    if @game.update(game_params)
      flash[:notice] = "Game Updated"
      redirect_to games_path
    else
      flash[:alert] = @game.errors.full_messages.join('. ')
      render :edit
    end
  end

  def show
    @game = Game.find(params[:id])
    @roster = Confirmation.where(game: @game)
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
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
      :opponent
    )
  end
end
