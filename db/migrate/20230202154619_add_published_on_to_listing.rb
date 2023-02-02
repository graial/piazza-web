class AddPublishedOnToListing < ActiveRecord::Migration[7.0]
  def change
    change_table :listings do |t|
      t.datetime :published_on
    end
  end
end
