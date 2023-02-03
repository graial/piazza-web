module Conversation::AccessPolicy
	def show?(organization = Current.organization)
		organization == seller ||
		organization == buyer
	end
	
	def can_message?
		show?
	end
end