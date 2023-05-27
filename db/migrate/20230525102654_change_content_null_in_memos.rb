class ChangeContentNullInMemos < ActiveRecord::Migration[7.0]
  def change
    change_column_null :memos, :content, false
  end
end
