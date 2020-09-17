class RemoveAdressFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :address, :string
  end
end
