class AddTeamToGames < ActiveRecord::Migration
  def change
    add_column :games, :team_id, :integer, null: false
  end
end
