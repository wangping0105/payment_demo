class CreateOrderPays < ActiveRecord::Migration[5.0]
  def change
    create_table :order_pays do |t|
      t.string :no
      t.integer :order_id, index: true
      t.integer :category
      t.integer :user_id, index: true
      t.integer :status, default:0, index: true

      t.timestamps
    end
  end
end
