module SetRequestVariant
	extend ActiveSupport::Concern

	included do 
		before_action :set_request_variant
	end

	private

	def set_request_variant
		if turbo_native_app?
			request.variant = :mobile
		else
			browser = Browser.new(request.user_agent)
			if browser.device.mobile?
				request.variant = :mobile
			else
				request.variant = :desktop
			end
		end
	end
end
