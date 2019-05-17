class Rentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      
      t.integer :movie_id
      t.integer :customer_id
      t.datetime :checkout_date
      t.datetime :due_date
      t.boolean :currently_checked_out, dafault: false

      t.timestamps
    end
    
  end
end
