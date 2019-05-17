class RemoveDefaultFromCheckoutDateAndDueDate < ActiveRecord::Migration[5.2]
  def change
    change_column_default :rentals, :checkout_date, nil
    change_column_default :rentals, :due_date, nil
  end
end
