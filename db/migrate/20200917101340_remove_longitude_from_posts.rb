class RemoveLongitudeFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :longitude, :float
  end
end
