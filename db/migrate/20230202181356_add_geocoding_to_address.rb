class AddGeocodingToAddress < ActiveRecord::Migration[7.0]
  def change
    change_table :addresses do |t|
      t.decimal :latitude
      t.decimal :longitude
    end
 
    add_index :addresses, [:latitude, :longitude]
  end
end
