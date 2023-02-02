module ListingsHelper
	def listing_status_tag_classes(listing)
		classes = ["tag"]
		classes << "is-danger" if listing.expired?

		classes.join(" ")
	end
end
