class Feed::Searches::TagsController < ApplicationController
	allow_unauthenticated
	
	before_action :unescape_tag
	drop_breadcrumb -> { "##{@tag}" }
	
	def show
		@search = Listings::Search.new(tags: [@tag])
		@pagy, @listings = pagy(@search.perform)
		
		render "feed/show"
	end

	private

	def unescape_tag
		@tag = CGI.unescape(params[:tag])
	end
end