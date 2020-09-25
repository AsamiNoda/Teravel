class ChangeDataAreaToPost < ActiveRecord::Migration[5.2]
  def change
  	change_column :posts, :area, :integer
  end
end
