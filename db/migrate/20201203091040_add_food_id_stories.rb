class AddFoodIdStories < ActiveRecord::Migration[6.0]
  def change
    add_column :stories, :food_id, :integer
  end
end
