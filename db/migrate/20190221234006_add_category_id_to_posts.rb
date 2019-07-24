class AddCategoryIdToPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts
    change_table :category_id
  end

  #def self.up
  #  change_table :posts do |t|
  #    t.integer :category_id
  #  end
#  end

end
