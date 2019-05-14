class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.date :checkout_date
      t.string :due_date
      t.string :date

      t.timestamps
    end
  end
end
