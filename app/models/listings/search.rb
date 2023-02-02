class Listings::Search
	include ActiveModel::Model
	
	attr_accessor :query, :location
	
	def perform
		if location.present?
			Listing.feed.search(query).near(location)
		else
			Listing.feed.search(query)
		end
	end
end