class CreatePlaylistVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :playlist_videos do |t|
      t.references :playlist, null: false, foreign_key: true
      t.references :video, null: false, foreign_key: true

      t.timestamps
    end
  end
end
