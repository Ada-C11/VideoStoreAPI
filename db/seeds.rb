JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  customer.merge!("movies_checked_out_count" => 0)
  Customer.create!(customer)
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  movie.merge!("available_inventory" => movie["inventory"])
  Movie.create!(movie)
end
