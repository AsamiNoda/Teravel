class DropTableAreas < ActiveRecord::Migration[5.2]
  def change
	  	drop_table :areas do |t|
	    t.string "name"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	  end
  end
end
