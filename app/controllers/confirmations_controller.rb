class ConfirmationsController < ApplicationController
  before_action :pre_claim
  def claim
    if @status.rsvp == false
      @status.rsvp = true
    else
      @status.rsvp = false
    end
    @status.save
    # redirect_to game_path(@game)
    @roster = Confirmation.where(game: @game, rsvp: true).order(updated_at: :asc)
    @current_user_status = Confirmation.where(game: @game, user: current_user)
    if @current_user_status.empty? || @current_user_status.first.rsvp == false
      @button_text = "Claim"
    else
      @button_text = "Relinquish"
    end
    respond_to do |format|
      # if @status.rsvp == true
      #   response = { name: @roster.last.user, button_name: @button_text }
      # else
      #   response = { button_name: @button_text }
      # end
      if @status.rsvp == true
        response = { name: @roster.last.user, button_name: @button_text }
      else
        response = { name: @status.user, button_name: @button_text }
      end
      format.json { render json: response }
      format.html { redirect_to game_path(@game) }
    end
  end

  private

  def pre_claim
    @game = Game.find(params[:game_id])
    @status = Confirmation.find_or_initialize_by(game: @game, user: current_user)
  end
end
