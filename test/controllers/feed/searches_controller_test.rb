require "test_helper"

class Feed::SearchesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @listing = listings(:auto_listing_1_kramer)
  end

  test "can search with query" do
    get search_path, params: {
      listings_search: {
          query: @listing.title
      }
    }
    assert_response :ok
    assert_select "h1", text: @listing.title
  end

  test "redirects to root without params" do
    get search_path
    
    assert_redirected_to root_path
  end

  test "can search with query and location" do
    get search_path, params: {
      listings_search: {
        query: @listing.title,
        location: "Birmingham"
      }
    }
    
    assert_response :ok
    assert_select "h1", text: @listing.title
  end
end