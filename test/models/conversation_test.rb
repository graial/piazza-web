require "test_helper"

class ConversationTest < ActiveSupport::TestCase
  setup do 
    @buyer = organizations(:jerry)
    @listing = listings(:auto_listing_1_george)
  end

  test "sets seller on creation" do 
    @conversation = Conversation.create(
      buyer: @buyer,
      listing: @listing
    )

    assert @conversation.persisted?
    assert_equal @listing.organization, @conversation.seller
  end
end

