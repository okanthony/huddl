class ConfirmationsController < ApplicationController
  before_action :pre_claim
  def claim
    if @status.rsvp == false
      @status.rsvp = true
    else
      @status.rsvp = false
    end
    @status.save
    redirect_to game_path(@game)
  end

  private

  def pre_claim
    @game = Game.find(params[:game_id])
    @status = Confirmation.find_or_initialize_by(game: @game, user: current_user)
  end
end
