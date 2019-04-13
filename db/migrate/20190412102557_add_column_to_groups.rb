class AddColumnToGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :groups, :key, :text
  end
end
