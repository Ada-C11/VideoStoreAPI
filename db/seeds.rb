JSON.parse(File.read("db/seeds/customers.json")).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read("db/seeds/movies.json")).each do |movie|
  Movie.create!(movie)
end

#set the available inventory for each movie equals to the movie's inventory
movies = Movie.all
movies.each do |movie|
  movie.available_inventory = movie.inventory
  movie.save
end
