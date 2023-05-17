class CreateUservideos < ActiveRecord::Migration[7.0]
  def change
    create_table :uservideos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true
      t.integer :watched_status, default: 0, null: false
      t.datetime :watched_at
      t.datetime :practiced_at

      t.timestamps
    end
  end
end
