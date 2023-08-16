class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :thumbnail_url
      t.text :embed_code
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
