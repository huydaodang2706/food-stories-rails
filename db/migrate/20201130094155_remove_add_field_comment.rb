class RemoveAddFieldComment < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :stories
    add_column :comments, :story_id, :integer
  end
end
