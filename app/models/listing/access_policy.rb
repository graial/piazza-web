module Listing::AccessPolicy
	def show?
		true
	end

	def edit?
		organization == Current.organization
	end

	def update?
		organization == Current.organization
	end

	def destroy?
		organization == Current.organization
	end

	def can_save?
		organization != Current.organization
	end
end