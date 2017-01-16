class CreateCommodities < ActiveRecord::Migration[5.0]
  def change
    create_table :commodities do |t|
      t.string :name
      t.string :no
      t.string :introduction
      t.float :price
      t.integer :category_id, index: true
      t.integer :stock, comment: '库存'
      t.integer :status, default:0, index: true

      t.timestamps
    end
  end
end
