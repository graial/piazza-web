require 'test_helper'

class BreadcrumbsTestsController < TestController
	include Breadcrumbs

	before_action :load_listing

	drop_breadcrumb "Home", :root_path
	drop_breadcrumb -> { @listing.title },
					-> { listing_path(@listing) },
					except: :new

	def edit
		drop_breadcrumb "Edit", edit_listing_path(@listing)
	end

	private

	def default_render
		render plain: breadcrumbs.to_a.map { _1.to_s }.join(", ")
	end

	def load_listing
		@listing = Listing.first
	end
end

class BreadcrumbsTest < ActionDispatch::IntegrationTest
	setup do 
		@listing = Listing.first

		draw_test_routes do 
			resource :breadcrumbs_test
		end
	end

	test "all actions have the home crumb" do 
		get breadcrumbs_test_path
		assert_response :ok 
		assert_match /Home: #{root_path}/, response.body

		get new_breadcrumbs_test_path
		assert_response :ok
		assert_match "Home: #{root_path}", response.body

		get edit_breadcrumbs_test_path
		assert_response :ok 
		assert_match /Home: #{root_path}/, response.body

		post breadcrumbs_test_path
		assert_response :ok 
		assert_match /Home: #{root_path}/, response.body

		delete breadcrumbs_test_path
		assert_response :ok 
		assert_match /Home: #{root_path}/, response.body
	end

	test "new path does not have listing title crumb" do 
		get new_breadcrumbs_test_path
		assert_response :ok 
		assert_no_match /#{@listing.title}: #{listing_path(@listing)}/,
		response.body
	end

	test "edit path has the edit crumb" do 
		get edit_breadcrumbs_test_path
		assert_response :ok 

		assert_match /Edit: #{edit_listing_path(@listing)}/,
		response.body
	end
end