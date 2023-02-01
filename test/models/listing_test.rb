require "test_helper"

class ListingTest < ActiveSupport::TestCase
  setup do 
    @user = users(:jerry)
    @listing = listings(:auto_listing_1_jerry)
  end

  test "downcases tags before saving" do 
    @listing.tags = ["Electronics", "Tools"]
    @listing.save

    assert_equal ["electronics", "tools"], @listing.tags
  end

  test "can check if the current user has saved a listing" do
    Current.user = @user
    assert_not @listing.saved?
    @user.saved_listings << @listing
    assert @listing.saved?
  end
    
  test "returns false when checking if saved without a current user" do
      assert_not @listing.saved?
  end
end