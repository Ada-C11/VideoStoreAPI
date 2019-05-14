JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  Movie.create!(movie)
  current_movie = Movie.last
  current_movie.available_inventory = current_movie.inventory
  current_movie.save
end
