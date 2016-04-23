class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.belongs_to :user, null: false
      t.belongs_to :game, null: false
      t.boolean :rsvp, default: false
    end
  end
end
