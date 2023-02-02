require "test_helper"
class Listing::PublishableTest < ActiveSupport::TestCase
	setup do
		@user = users(:jerry)
		@listing = listings(:auto_listing_1_jerry)
	end

	test "sets published_on when creating a published listing" do
		@listing = create_listing
		assert_not_nil @listing.published_on
	end

	test "does not set published_on when creating a draft" do
		@listing = create_listing(status: "draft")
		assert_nil @listing.published_on
	end

	test "sets published_on when publishing a draft listing" do
		@listing.update(status: "draft", published_on: nil)
		assert_nil @listing.published_on
		@listing.update(status: "published")
		assert_not_nil @listing.published_on
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