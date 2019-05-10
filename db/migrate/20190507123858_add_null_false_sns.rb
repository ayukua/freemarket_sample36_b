class AddNullFalseSns < ActiveRecord::Migration[5.0]
  def change
    # change_column_null :sns_credentials, :name, null: false
    # change_column_null :sns_credentials, :email, null: false
    # change_column_null :sns_credentials, :provider, null: false
    # change_column_null :sns_credentials, :uid, null: false

    add_index :sns_credentials, :email, unique: true
  end

  def up
    change_column_null :sns_credentials, :name, false
    change_column_null :sns_credentials, :email, false
    change_column_null :sns_credentials, :provider, false
    change_column_null :sns_credentials, :uid, false

    change_column :sns_credentials, :name, :string, default: ""
    change_column :sns_credentials, :email, :string, default: ""
    change_column :sns_credentials, :provider, :string, default: ""
    change_column :sns_credentials, :uid, :string, default: ""
  end

  def down
    change_column_null :sns_credentials, :name, true, nil
    change_column_null :sns_credentials, :email, true, nil
    change_column_null :sns_credentials, :provider, true, nil
    change_column_null :sns_credentials, :uid, true, nil

    change_column :sns_credentials, :name, :string, default: nil
    change_column :sns_credentials, :email, :string, default: nil
    change_column :sns_credentials, :provider, :string, default: nil
    change_column :sns_credentials, :uid, :string, default: nil
  end
end
