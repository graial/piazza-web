require "test_helper"

class Listings::ContactControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    @conversation = conversations(:jerry_elaine_1)
    
    log_in @user
  end

  test "creates conversation when one doesn't exist" do
    @listing = listings(:auto_listing_1_george)
    assert_difference "Conversation.count", 1 do
      get listing_contact_path(@listing)
    end

    assert_response :ok
    assert_select ".modal.is-active"
  end

  test "can view existing conversation" do
    assert_no_difference "Conversation.count" do
      get listing_contact_path(@conversation.listing)
    end

    assert_response :ok
    assert_select ".modal.is-active"
  end

  test "cannot contact for own listing" do
    @listing = listings(:auto_listing_1_jerry)
    get listing_contact_path(@listing)
    assert_response :forbidden
  end
end