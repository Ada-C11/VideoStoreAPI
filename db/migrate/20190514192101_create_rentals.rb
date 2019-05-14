class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.datetime :checkout_date
      t.datetime :due_date

      t.timestamps
    end
  end
end
