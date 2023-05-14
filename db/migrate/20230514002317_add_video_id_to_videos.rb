class AddVideoIdToVideos < ActiveRecord::Migration[7.0]
  def change
    add_column :videos, :video_id, :string
  end
end
