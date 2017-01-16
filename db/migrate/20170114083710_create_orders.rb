class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.string :no
      t.integer :commodity_id, index: true
      t.float :origin_price
      t.float :discount
      t.float :price
      t.integer :user_id, index: true
      t.integer :status

      t.timestamps
    end
  end
end
