require "test_helper"

class Feed::Searches::TagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = listings(:auto_listing_1_elaine)
  end
 
  test "can search with a single tag" do
    get tags_search_path(@listing.tags.first)

    assert_response :ok
    assert_match "##{@listing.tags.first}", @response.body
  end

  test "unescapes tag before processing" do
    get tags_search_path("two+words")
  
    assert_response :ok
    assert_match "#two words", @response.body
  end
end
