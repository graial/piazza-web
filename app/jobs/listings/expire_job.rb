class Listings::ExpireJob < ApplicationJob
  queue_as :default

  def perform(listing)
    return if listing.expired?

    if listing.expiry_date.past?
      listing.expired!
    else
      self.class
        .set(wait_until: listing.expiry_date)
        .perform_later(listing)
    end
  end
end
