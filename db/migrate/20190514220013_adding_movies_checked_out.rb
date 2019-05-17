class AddingMoviesCheckedOut < ActiveRecord::Migration[5.2]
  def change
    add_column :customers, :movies_checked_out_count, :integer

    Customer.find_each do |customer|
      customer.movies_checked_out_count = 0
      customer.save!
    end
  end
end
