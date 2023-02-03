class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :listing, foreign_key: { on_delete: :cascade }

      t.references :seller, foreign_key: { to_table: :organizations }
      t.references :buyer, foreign_key: { to_table: :organizations }

      t.index [:seller_id, :buyer_id, :listing_id], unique: true

      t.timestamps
    end
  end
end
