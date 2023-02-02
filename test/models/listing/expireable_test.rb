require "test_helper"
class Listing::ExpireableTest < ActiveSupport::TestCase
	include ActiveJob::TestHelper
	
	setup do
		@user = users(:jerry)
		@listing = listings(:auto_listing_1_jerry)
	end

	test "queues expire job when creating a published listing" do
		assert_enqueued_with(job: Listings::ExpireJob) do
			create_listing
		end
	end

	test "does not queue expire job when creating a draft listing" do
		assert_no_enqueued_jobs(only: Listings::ExpireJob) do
			create_listing(status: "draft")
		end
	end

	test "queues expire job when publishing a draft listing" do
		@listing.update(status: "draft", published_on: nil)
		assert_enqueued_with(job: Listings::ExpireJob) do
			@listing.update(status: "published")
		end
	end
	private

	def create_listing(attrs = {})
		Listing.create({
			title: Faker::Commerce.product_name,
			creator: @user,
			organization: @user.organizations.first,
			cover_photo: active_storage_blobs(:blob_1),
			price: Faker::Commerce.price.floor,
			condition: "mint",
			tags: Faker::Commerce.send(:categories, 3),
			description: Faker::Lorem.paragraphs(number: 4).map { "<p>#{_1}</p>"}.join,
			address_attributes: {
				line_1: Faker::Address.building_number,
				line_2: Faker::Address.street_address,
				city: Faker::Address.city,
				postcode: Faker::Address.postcode,
				country: "GB"
			}
		}.merge(attrs))
	end
end