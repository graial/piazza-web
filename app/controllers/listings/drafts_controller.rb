class Listings::DraftsController < ApplicationController
	before_action :load_listing, only: :update
	skip_authorization only: :create

	def create
		@listing = Listing.new(
			listing_params.with_defaults(
				creator: Current.user,
				organization: Current.organization,
				status: :draft
			)
		)

		if @listing.save
			flash[:success] = t(".success")
			recede_or_redirect_to listing_path(@listing),
				status: :see_other
		else
			render "listings/new", status: :unprocessable_entity
		end
	end


	def update
		@listing.assign_attributes(
			listing_params.with_defaults(
				status: :draft
			)
		)

		if @listing.save 
			flash[:success] = t(".success")
			recede_or_redirect_to listing_path(@listing),
				status: :see_other
		else
			render "listings/edit", status: :unprocessable_entity
		end
	end

	private

	def load_listing
		@listing = Listing.find(params[:listing_id])
	end

	def listing_params
		params.require(:listing).permit(
			Listing.permitted_attributes
		)
	end

	def authorizable_resource
		@listing = Listing.find(params[:listing_id])
	end
end