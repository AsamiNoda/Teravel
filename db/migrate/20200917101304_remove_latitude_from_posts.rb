class RemoveLatitudeFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :latitude, :float
  end
end
