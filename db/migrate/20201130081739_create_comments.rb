class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :stories
      t.text :content

      t.timestamps
    end
  end
end
