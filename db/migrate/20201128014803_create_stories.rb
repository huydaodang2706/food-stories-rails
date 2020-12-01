class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :content
      t.string :location
      t.integer :user_id
      t.integer :food_id
      t.string :recommendation

      t.timestamps
    end
  end
end
