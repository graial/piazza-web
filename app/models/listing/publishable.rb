module Listing::Publishable
	extend ActiveSupport::Concern

	included do 
		before_create :set_published_date, if: :published?
		before_save :set_published_date,
			if: -> { status_change_to_be_saved in [_, "published"] }
	end

	private

	def set_published_date
		self.published_on = Time.zone.now 
	end
end