class MyListingsController < ApplicationController
	
	drop_breadcrumb I18.t("my_listings.show.title")

	def show
		@pagy, @listings = pagy(Current.organization.listings)
	end
end
