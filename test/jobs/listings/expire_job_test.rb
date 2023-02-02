require "test_helper"

class Listings::ExpireJobTest < ActiveJob::TestCase
  setup do
    @listing = listings(:auto_listing_1_jerry)
  end

  test "expires a listing beyond expiry date" do 
    travel_to 31.days.from_now
    assert @listing.expiry_date.past?

    Listings::ExpireJob.perform_now(@listing)
    assert @listing.expired?
  end

  test "queues another job for listing within expiry" do
    assert_not @listing.expiry_date.past?
    
    assert_enqueued_with(
      job: Listings::ExpireJob, at: @listing.expiry_date
    ) do
      Listings::ExpireJob.perform_now(@listing)
      assert_not @listing.expired?
    end
  end
end
