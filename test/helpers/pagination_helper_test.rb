require 'test_helper'

class PaginationHelperTest < ActionView::TestCase
	setup do 
		@turbo_native_app = false
	end

	test "dont show paginator in native apps" do 
		@turbo_native_app = true
		assert_not show_paginator?
	end

	test "dont show paginator when theres only 1 page" do 
		@pagy = Struct.new(:pages).new(2)
		assert show_paginator?
	end

	test "show paginator when there's more than one page" do
		@pagy = Struct.new(:pages).new(2)
		assert show_paginator?
	end
	
	private

	def turbo_native_app?
		@turbo_native_app
	end
end