class CreateItemCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :item_categories do |t|
      t.references      :item,      null: false,    foring_key: true
      t.references      :categoty,  null: false,    foring_key: true

      t.timestamps
    end
  end
end
