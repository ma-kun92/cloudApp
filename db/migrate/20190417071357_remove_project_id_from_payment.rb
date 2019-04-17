class RemoveProjectIdFromPayment < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :payments, :projects
  end
end
