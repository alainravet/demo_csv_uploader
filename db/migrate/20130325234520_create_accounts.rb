class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.integer :balance_in_cents

      t.timestamps
    end
  end
end
