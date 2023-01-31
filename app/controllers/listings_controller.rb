class ListingsController < ApplicationController
	before_action :load_listing, except: [:new, :create]
	allow_unauthenticated only: :show

	def new
		@listing = Listing.new
		@listing.build_address
	end

	def create
		@listing = Listing.new(
			listing_params.with_defaults(
				creator: Current.user,
				organization: Current.organization
			)
		)

		if @listing.save
			redirect_to listing_path(@listing),
			flash: { success: t(".success") },
			status: :see_other
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
	end
	
	def edit 
	end
	
	def update
		if @listing.update(listing_params)
			redirect_to listing_path(@listing),
				status: :see_other,
				flash: { success: t(".success") }
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@listing.destroy
		redirect_to my_listings_path,
			status: :see_other,
			flash: { success: t(".success") }
	end

	private

	def load_listing
		@listing = Listing.find(params[:id])
	end

	def listing_params
		params.require(:listing).permit(
			Listing.permitted_attributes
		)
	end
end