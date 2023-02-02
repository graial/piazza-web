class FeedController < ApplicationController
  allow_unauthenticated 

  def show
    @search = Listings::Search.new
    @pagy, @listings = pagy(Listing.feed)
  end
end
