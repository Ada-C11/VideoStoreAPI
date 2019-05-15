require "test_helper"

describe RentalsController do
  describe "check_out" do
    it "checks out a movie" do
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id
      }

      expect {
        post check_out_path(rental_params)
      }.must_change "Rental.count", +1
    end
    
    it "changes the inventory of checked out movie" do
      start_inventory = movies(:movie1).inventory
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id
      }
  
      post check_out_path(rental_params)

      end_inventory = Movie.find_by(id: movies(:movie1).id).inventory
      expect(end_inventory).must_equal start_inventory - 1
  
    end

    it "changes the inventory of checked out movie when it checked out more than once" do
      start_inventory = movies(:movie1).inventory
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: movies(:movie1).id
      }
  
      post check_out_path(rental_params)
      post check_out_path(rental_params)
      post check_out_path(rental_params)

      end_inventory = Movie.find_by(id: movies(:movie1).id).inventory
      expect(end_inventory).must_equal start_inventory - 3
  
    end


    it "does not check out for a customer that does not exist" do
      rental_params = {
        customer_id: -1,
        movie_id: movies(:movie1).id
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end

    it "does not check out for a movie that does not exist" do
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: -1
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end

    it "does not check out for movie with inventory of 0" do
      no_movies = Movie.create(title: "titanic", overview: "movie", release_date: Date.today, inventory:0)
        
      rental_params = {
        customer_id: customers(:customer1).id,
        movie_id: no_movies.id
      }

      expect {
        post check_out_path(rental_params)
      }.wont_change "Rental.count"
    end

  end
end
