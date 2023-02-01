class ListingsController < ApplicationController
	before_action :load_listing, except: [:new, :create]
	allow_unauthenticated only: :show

	drop_breadcrumb -> { @listing.title },
					-> { listing_path(@listing) },
					except: [:new, :create]

	def new
		drop_breadcrumb t("listings.breadcrumbs.new")
		@listing = Listing.new
		@listing.build_address
	end

	def create
		drop_breadcrumb t("listings.breadcrumbs.new")
		@listing = Listing.new(
			listing_params.with_defaults(
				creator: Current.user,
				organization: Current.organization
			)
		)

		if @listing.save
			flash[:success] = t(".success")
			recede_or_redirect_to listing_path(@listing),
				status: :see_other
		else
			render :new, status: :unprocessable_entity
		end
	end

	def show
	end
	
	def edit 
		drop_breadcrumb t("listings.breadcrumbs.edit")
	end
	
	def update
		drop_breadcrumb t("listings.breadcrumbs.edit")
		if @listing.update(listing_params)
			flash[:success] = t(".success")
			recede_or_redirect_to listing_path(@listing),
				status: :see_other
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		@listing.destroy
		flash[:success] = t(".success")
		recede_or_redirect_to my_listings_path,
			status: :see_other
	end

	private

	def load_listing
		@listing = Listing.find(params[:id])
	end

	def listing_params
		defaults = { tags: [] }
		params.require(:listing).permit(
			Listing.permitted_attributes
		).reverse_merge(defaults)
	end
end