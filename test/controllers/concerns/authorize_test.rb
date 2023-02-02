require 'test_helper'

class AuthorizeTestsController < TestController
	include Authenticate
	include Authorize
	
	helper_method :turbo_native_app?
	skip_authorization only: :new

	def new 
	end

	def show
	end

	private

	def authorizable_resource
		@authorizable = Authorizable.new
	end
end

class Authorizable
	def show?
		user_id = ActiveRecord::FixtureSet.identify("jerry")

		Current.user == User.find(user_id)
	end
end

class AuthorizeTest < ActionDispatch::IntegrationTest
	setup do 
		@user = users(:jerry)
		@unauthorized_user = users(:kramer)

		draw_test_routes do 
			resource :authorize_test, only: [:new, :show]
		end
	end

	teardown do 
		reload_routes!
	end

	test "unauthorized user can access the new action" do
		log_in(@unauthorized_user)

		get new_authorize_test_path

		assert_response :ok
		assert_match /authorize_tests#new/, response.body
	end

	test "unauthorized user cannot access the show action" do
		log_in(@unauthorized_user)
	
		get authorize_test_path
	
		assert_response :forbidden
	end

	test "authorized user can access the show action" do
		log_in(@user)
	
		get authorize_test_path
	
		assert_response :ok
		assert_match /authorize_tests#show/, response.body
	end
end