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

	test "can filter by single tag" do
		@listings = Listings::Search.new(
			tags: [@listing.tags.first]
		).perform
		
		assert @listings.find(@listing.id)
	end

	test "can filter by multiple tags" do
		@listings = Listings::Search.new(
			tags: @listing.tags
		).perform

		assert @listings.find(@listing.id)
	end

	test "no results when tags don't match" do
		@listings = Listings::Search.new(
			tags: ["∞"]
		).perform
		
		assert @listings.empty?
	end

	test "nilifies empty query on initilization" do
		@search = Listings::Search.new(
			query: ""
		)
	
		assert @search.query.nil?
	end
	test "nilifies empty location on initilization" do
		@search = Listings::Search.new(
			location: ""
		)
	
		assert @search.location.nil?
	end

	test "nilifies empty tags on initilization" do
		@search = Listings::Search.new(
			tags: [""]
		)

		assert @search.tags.nil?
	end
end