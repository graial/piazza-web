class SavedListingsController < ApplicationController
	before_action :load_listing, except: :show

	def create
		Current.user.saved_listings << @listing		
	end

	def show
		drop_breadcrumb t(".title")

		@pagy, @listings = pagy(Current.user.saved_listings)

		render :show 
	end

	def destroy
		Current.user.saved_listings.destroy(@listing)
	end

	private

	def load_listing
		@listing = Listing.find(params[:listing_id])
	end

	def default_render
		render turbo_stream: turbo_stream.update(
			"save_button",
			partial: "listings/save_button",
			locals: {
				listing: @listing
			}
		)
	end
end