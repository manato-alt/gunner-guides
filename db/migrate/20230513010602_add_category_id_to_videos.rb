class AddCategoryIdToVideos < ActiveRecord::Migration[7.0]
  def change
    add_reference :videos, :category, null: false, foreign_key: true
  end
end
