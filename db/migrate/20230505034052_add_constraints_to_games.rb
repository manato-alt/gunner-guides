class AddConstraintsToGames < ActiveRecord::Migration[7.0]
  def change
    change_column_null :games, :title, false
    add_index :games, :title, unique: true
  end
end
