JSON.parse(File.read('db/seeds/customers.json')).each do |customer|
  Customer.create!(customer)
end

JSON.parse(File.read('db/seeds/movies.json')).each do |movie|
  movie_new = Movie.create!(movie)
  movie_new.update(available_inventory: movie_new.inventory)

end
