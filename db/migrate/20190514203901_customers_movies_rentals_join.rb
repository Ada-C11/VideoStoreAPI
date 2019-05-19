class CustomersMoviesRentalsJoin < ActiveRecord::Migration[5.2]
  def change
    def change
      create_table :customers_movies do |t|
        t.belongs_to :customer, index: true
        t.belongs_to :movie, index: true
      end
    end
  end
end
