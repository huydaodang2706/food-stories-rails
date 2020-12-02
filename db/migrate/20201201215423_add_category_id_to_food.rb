class AddCategoryIdToFood < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :category_id, :integer
  end
end
