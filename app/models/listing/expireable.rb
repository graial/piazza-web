module Listing::Expireable
	extend ActiveSupport::Concern

	included do 
		after_save_commit :queue_expire_job,
			if: -> {
				(id_previously_was.nil? && published?) ||
				(status_previous_change in [_, "published"])
			}
	end

	def expiry_date
		published_on.end_of_day + 30.days
	end

	private

	def queue_expire_job
		Listings::ExpireJob
			.set(wait_until: expiry_date)
			.perform_later(self)
	end
end