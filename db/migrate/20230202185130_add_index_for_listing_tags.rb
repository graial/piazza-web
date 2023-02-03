class AddIndexForListingTags < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!
  
  def change
    add_index :listings,
      :tags,
      using: :gin,
      algorithm: :concurrently
  end
end
