module PaginationHelper
	def show_paginator?
		!turbo_native_app? && @pagy.pages > 1
	end
end
