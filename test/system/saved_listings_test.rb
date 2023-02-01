require "application_system_test_case"

class SavedListingTest < ApplicationSystemTestCase
	setup do 
		@user = users(:jerry)
		@listing = listings(:auto_listing_1_kramer)

		log_in(@user)
	end

	test "can save an ad" do
		visit listing_path(@listing)
		
		click_on I18n.t("listings.save_button.save")
		assert_button I18n.t("listings.save_button.unsave")
		visit saved_listings_path

		assert_text @listing.title
	end

	test "can un-save an ad" do
		@user.saved_listings << @listing
		visit listing_path(@listing)
		click_on I18n.t("listings.save_button.unsave")
		assert_button I18n.t("listings.save_button.save")
		visit saved_listings_path
		assert_no_text @listing.title
	end
end