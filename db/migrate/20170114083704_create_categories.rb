class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :commodities_count, default: 0

      t.timestamps
    end
  end
end
