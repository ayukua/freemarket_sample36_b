class AddForeignkey < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key "images", "products", column: :"item_id"
    add_foreign_key "statuses", "products", column: :"item_id"
    add_foreign_key "item_categories", "products", column: :"item_id"
  end
end
