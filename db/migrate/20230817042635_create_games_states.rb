class CreateGamesStates < ActiveRecord::Migration[7.0]
  def change
    create_table :games_states do |t|
      t.string :title

      t.timestamps
    end
  end
end
