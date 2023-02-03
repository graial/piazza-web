class ApplicationController < ActionController::Base
	include SetRequestVariant
	include Authenticate
	include SetCurrentRequestDetails
	include Authorize

	include Breadcrumbs
	include Pagy::Backend
	
	before_action :set_request_variant

	helper_method :turbo_frame_request?
	helper_method :turbo_native_app?

	private

	def set_request_variant
		request.variant = :mobile
	end
end
