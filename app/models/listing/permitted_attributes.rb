module Listing::PermittedAttributes
	extend ActiveSupport::Concern

	class_methods do 
		def permitted_attributes
			[
				:title, :price, :condition, tags: [],
				address_attributes: Address.permitted_attributes
			]
		end
	end
end