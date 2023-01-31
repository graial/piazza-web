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
end