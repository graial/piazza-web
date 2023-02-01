module Breadcrumbs
	extend ActiveSupport::Concern

	included do 
		helper_method :breadcrumbs
	end

	class_methods do 
		def drop_breadcrumb(*args, **options)
			label, path = args 

			before_action(options) do |controller|
				controller.drop_breadcrumb(label, path)
			end
		end
	end

	protected

	def drop_breadcrumb(label, path = nil)
		path = send(path) if path.is_a? Symbol

		label = instance_exec(&label) if label.is_a? Proc
		path = instance_exec(&path) if path.is_a? Proc

		breadcrumbs << Crumb.new(label, path)
	end

	private

	def breadcrumbs
		@breadcrumbs ||=Trail.new 
	end
end