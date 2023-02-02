class Feed::SearchesController < ApplicationController
	allow_unauthenticated

	rescue_from ActionController::ParameterMissing do 
		redirect_to root_path, status: :see_other
	end

	def show
		@search = Listings::Search.new(search_params)
		@pagy, @listings = pagy(@search.perform)

		render "feed/show"
	end

	private

	def search_params
		params.require(:listings_search).permit(:query, :location)
	end
end
