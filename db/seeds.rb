JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  movie_new = Movie.new(movie)
  movie_new.available_inventory = movie_new.inventory
  movie_new.save
end
