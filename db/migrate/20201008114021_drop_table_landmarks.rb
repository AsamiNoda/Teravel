class DropTableLandmarks < ActiveRecord::Migration[5.2]
  def change
    drop_table :landmarks
  end
end
