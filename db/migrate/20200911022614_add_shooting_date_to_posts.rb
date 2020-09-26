class AddShootingDateToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :shooting_date, :date
  end
end
