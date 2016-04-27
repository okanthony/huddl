class SelectorController < ApplicationController
  def index
    @team = Team.new
    @sports = Team::SPORTS
  end
end
