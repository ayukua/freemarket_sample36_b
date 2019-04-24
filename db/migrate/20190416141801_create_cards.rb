class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.references  :user,        null: false
      t.string      :customer_id, null: false
      t.string      :card_id,     null: false, unique: true
      t.timestamps
    end
  end
end
