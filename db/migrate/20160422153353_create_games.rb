class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :street, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.date :game_day, null: false
      t.time :game_time, null: false
      t.string :opponent
    end
  end
end
