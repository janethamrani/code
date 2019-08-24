class AddThumbnailToPosts < ActiveRecord::Migration[5.2]
  def self.up
    add_attachment :posts, :thumbnail
  end

  def self.down
    remove_attachment :posts, :thumbnail
  end
end
