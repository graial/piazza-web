module Conversation::AccessPolicy
	def show?
		Current.organization == seller ||
		Current.organization == buyer
	end
	
	def can_message?
		show?
	end
end