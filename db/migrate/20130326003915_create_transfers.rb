class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.references :origin
      t.references :destination
      t.string :amount_in_cents

      t.timestamps
    end
    add_index :transfers, :origin_id
    add_index :transfers, :destination_id
  end
end
