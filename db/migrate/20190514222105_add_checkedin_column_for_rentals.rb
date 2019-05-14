# frozen_string_literal: true

class AddCheckedinColumnForRentals < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :checked_in, :boolean, default: false
  end
end
