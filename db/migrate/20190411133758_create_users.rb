class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string,null: false
    add_column :users, :payjp_id, :text
    add_column :users, :remember_me_token, :string, :default => nil
    add_column :users, :remember_me_token_expires_at, :datetime, :default => nil
    add_index :users, :remember_me_token
  end
end
