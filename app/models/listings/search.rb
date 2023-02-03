class Listings::Search
	include ActiveModel::Model
	
	attr_accessor :query, :location, :tags
	
	def initialize(attributes={})
		super
		
		self.query = nil unless query.present?
		self.location = nil unless location.present?
		self.tags = nil unless tags&.compact_blank.present?
	end

	def perform
		case [query, location, tags]
		in [String, nil, nil]
			Listing.feed.search(query)
		in [String, String, nil]
			Listing.feed.search(query).near(location)
		in [nil, nil, Array]
			Listing.feed.filter_by_tags(tags)
		else
			raise "Error in search data"
		end
	end
end