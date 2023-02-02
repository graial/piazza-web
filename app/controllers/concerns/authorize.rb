module Authorize
	extend ActiveSupport::Concern

	included do 
		before_action :authorize_resource_access
		rescue_from NotAuthorizedError, with: :render_forbidden_error
	end

	class_methods do 
		def skip_authorization(**options)
			skip_before_action :authorize_resource_access, options
		end
	end
	protected

	def authorize!(value)
		raise NotAuthorizedError unless value
	end

	private

	def authorize_resource_access
		authorized = authorizable_resource.send("#{params[:action]}?")
		raise NotAuthorizedError unless authorized
	rescue NotImplementedError
		true #if no resource, the request is authorized
	end
	
	def render_forbidden_error
		render file: "#{Rails.root}/public/404.html",
			status: :forbidden,
			layout: false
	end

	def authorizable_resource	
		raise NotImplementedError
	end
end

class NotAuthorizedError < StandardError
end