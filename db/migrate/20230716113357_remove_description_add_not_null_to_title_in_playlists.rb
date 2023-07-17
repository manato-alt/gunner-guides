class RemoveDescriptionAddNotNullToTitleInPlaylists < ActiveRecord::Migration[7.0]
  def change
    remove_column :playlists, :description
    change_column_null :playlists, :title, false
  end
end
