class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.datetime :checkout
      t.datetime :due

      t.timestamps
    end
  end
end
