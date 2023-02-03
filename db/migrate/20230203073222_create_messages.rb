class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :body

      t.references :conversation, foreign_key: { on_delete: :cascade }

      t.references :from, foreign_key: { to_table: :organizations }

      t.references :sender, 
        foreign_key: {
          to_table: :users,
          on_delete: :nullify
        }

      t.timestamps
    end
  end
end
