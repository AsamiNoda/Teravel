class RenamePlaceColumnToPosts < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :place, :country

  end
end
