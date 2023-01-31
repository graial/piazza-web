class MyListingsController < ApplicationController
	def show
		@pagy, @listings = pagy(Current.organization.listings)
	end
end
