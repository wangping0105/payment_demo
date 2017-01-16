class CreateUserAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accounts do |t|
      t.integer :user_id, index: true
      t.float :amount, default: 0
      t.float :total_amount, default: 0
      t.float :frozen_amount, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
