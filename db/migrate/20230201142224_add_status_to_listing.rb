class AddStatusToListing < ActiveRecord::Migration[7.0]
  def change
    create_enum :listing_status,
      [:draft, :published, :expired]
    
    change_table :listings do |t|
      t.enum :status, enum_type: :listing_status, default: :published
    end
  end
end
