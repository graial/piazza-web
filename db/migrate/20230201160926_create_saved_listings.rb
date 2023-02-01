class CreateSavedListings < ActiveRecord::Migration[7.0]
  def change
    create_join_table(
      :users,
      :listings,
      table_name: "saved_listings",
      column_options: {
        foreign_key: { on_delete: :cascade }
      }
    ) do |t|
      t.index [ :user_id, :listing_id ], unique: true
    end
  end
end
