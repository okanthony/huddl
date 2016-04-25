class AddLatitudeAndLongitudeToGames < ActiveRecord::Migration
  def change
    add_column :games, :latitude, :float
    add_column :games, :longitude, :float
  end
end
