JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  Movie.create!(movie)
end

# Movie.find_each do |movie|
#   movie.available_inventory = movie.inventory
#   movie.save
# end
