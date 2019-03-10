class AddCategoryIdToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :category_id
  end
  def self.up
    change_table :posts do |t|
      t.integer :category_id
    end
end
