require "test_helper"

class Listings::SearchTest < ActiveSupport::TestCase
	setup do
		@listing = listings(:auto_listing_1_jerry)
	end
	
	test "can search with query only" do
		@listings = Listings::Search.new(
			query: @listing.title
		).perform

		assert @listings.find(@listing.id)
	end

	test "can search with query and location" do
		@listings = Listings::Search.new(
			query: @listing.title,
			location: "London"
		).perform
		
		assert @listings.find(@listing.id)
	end

	test "no results when query doesn't match" do
		@listings = Listings::Search.new(
			query: "A trilogy in five parts"
		).perform
		
		assert @listings.empty?
	end

	test "no results when location doesn't match" do
		@listings = Listings::Search.new(
			query: @listing.title,
			location: "Timbuktoo"
		).perform
	
		assert @listings.empty?
	end
end