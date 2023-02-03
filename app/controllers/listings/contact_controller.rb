class Listings::ContactController < ApplicationController
	before_action :load_listing
	before_action -> { authorize! @listing.can_contact? }

	def show
		@conversation = @listing.conversations.find_or_create_by(
			buyer: Current.organization
		)

		@message = @conversation.messages.build
	end

	private

	def load_listing
		@listing = Listing.find(params[:listing_id])
	end
end