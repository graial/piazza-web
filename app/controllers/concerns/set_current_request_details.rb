module SetCurrentRequestDetails
	extend ActiveSupport::Concern

	included do 
		before_action :set_current_organization,
			if: -> { Current.user.present? }
	end

	private

	def set_current_organization
		Current.organization = Current.user.organizations.first 
	end
end