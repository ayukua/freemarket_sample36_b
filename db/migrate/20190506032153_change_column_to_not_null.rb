class ChangeColumnToNotNull < ActiveRecord::Migration[5.0]
  def up
    change_column_null :users, :postal_code, :string, true
    change_column_null :users, :prefecture, :string, true
    change_column_null :users, :city, :string, true
    change_column_null :users, :block_number, :integer, true
  end
end
