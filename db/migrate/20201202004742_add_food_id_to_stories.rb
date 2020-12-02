class AddFoodIdToStories < ActiveRecord::Migration[6.0]
  def change
    add_column :stories, :food_id, :string
  end
end
