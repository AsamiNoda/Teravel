class RemoveAreaIdFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :area_id, :integer
  end
end
