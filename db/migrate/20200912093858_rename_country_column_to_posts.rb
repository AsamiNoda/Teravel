class RenameCountryColumnToPosts < ActiveRecord::Migration[5.2]
  def change
  	    rename_column :posts, :country, :country_name
  end
end
