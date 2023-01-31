module ApplicationHelper
	include Pagy::Frontend

	def title 
		return t("piazza") unless content_for?(:title)
		return content_for(:title) if turbo_native_app?

		"#{content_for(:title)} | #{t("piazza")}"
	end

	private
end