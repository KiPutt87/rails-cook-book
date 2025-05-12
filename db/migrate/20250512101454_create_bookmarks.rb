class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.string :comment
      t.integer :recipe_id
      t.integer :category_id

      t.timestamps
    end
  end
end
