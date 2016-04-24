class HomeController < ApplicationController
  before_action :authenticate_user!
  def index
    @name = current_user.first_name
    @game = Game.where("game_day >= ?", Date.today).order("game_day ASC").limit(1).first
    @roster = Confirmation.where(game: @game, rsvp: true).order(updated_at: :asc)
  end
end
