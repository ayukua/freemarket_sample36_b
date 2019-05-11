class ChangeColumnToImages < ActiveRecord::Migration[5.0]
  def up
    change_column :images, :image, :text, null: false
  end

  def down
    change_column :images, :image, :text, null: true
  end
end
