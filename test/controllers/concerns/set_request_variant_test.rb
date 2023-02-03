require 'test_helper'
class SetRequestVariantTestsController < TestController
	include SetRequestVariant
	
	def show
		render plain: request.variant.first.to_s
	end

	test "sets variant to mobile for native apps" do
		get set_request_variant_test_path, headers: {
			"HTTP_USER_AGENT": "Turbo Native"
		}
		assert_equal "mobile", response.body
	end
end

class SetRequestVariantTest < ActionDispatch::IntegrationTest
	setup do
		draw_test_routes do
			resource :set_request_variant_test, only: [:show]
		end
	end

	test "sets variant as desktop by default" do
		get set_request_variant_test_path
		
		assert_equal "desktop", response.body
	end

	test "sets variant to mobile for mobile devices" do
		get set_request_variant_test_path, headers: {
			"HTTP_USER_AGENT": "MobileDevice"
		}
		
		assert_equal "mobile", response.body
	end
end