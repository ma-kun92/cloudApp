class AddColumnToPayment < ActiveRecord::Migration[5.0]
  def change
    add_reference :payments, :project, foreign_key: true
  end
end
