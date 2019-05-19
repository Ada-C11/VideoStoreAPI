JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  Customer.create!(customer)
  current_customer = Customer.last
  current_customer.movies_checked_out_count = 0
  current_customer.save
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  Movie.create!(movie)
  current_movie = Movie.last
  current_movie.available_inventory = current_movie.inventory
  current_movie.save
end
