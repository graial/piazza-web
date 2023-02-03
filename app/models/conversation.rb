class Conversation < ApplicationRecord
	include AccessPolicy
	
	belongs_to :listing
	belongs_to :seller, class_name: "Organization"
	belongs_to :buyer, class_name: "Organization"
	has_many :messages, dependent: :destroy

	before_validation :set_seller, unless: :persisted?

	private

	def set_seller
		self.seller = listing.organization
	end
end