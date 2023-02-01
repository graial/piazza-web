require "test_helper"

class Listings::DraftsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:jerry)
    log_in @user 
  end

  test "can create a listing" do 
    assert_difference "Listing.count", 1 do 
      post draft_listings_path, params: {
        listing: {
          title: Faker::Commerce.product_name,
          cover_photo: fixture_file_upload("test-image-1.jpg"),
          price: Faker::Commerce.price.floor,
          tags: ["churros"],
          condition: "mint",
          description: Faker::Lorem.paragraphs(number: 4).map {
"<p>#{_1}</p>"}.join,
          address_attributes: {
            line_1: Faker::Address.building_number,
            line_2: Faker::Address.street_address,
            city: Faker::Address.city,
            postcode: Faker::Address.postcode,
            country: "GB"
          }
        }
      }
    end

    assert_redirected_to listing_path(Listing.last)
    assert Listing.last.draft?
  end

  test "can update a draft listing" do
    @listing = listings(:auto_listing_1_jerry)
    @listing.draft!
    new_title = Faker::Commerce.product_name
    patch listing_draft_path(@listing), params: {
      listing: {
        title: new_title,
        price: @listing.price
      }
    }

    assert_redirected_to listing_path(@listing)
    assert_equal new_title, @listing.reload.title
    assert @listing.reload.draft?
  end

  test "shows errors when creating an invalid listing" do
    assert_no_difference "Listing.count" do
      post draft_listings_path, params: {
        listing: {
          title: "title",
          price: 300,
          condition: "mint"
        }
      }
    end
    assert_response :unprocessable_entity
    assert_select "p.is-danger"
  end

  test "shows errors when updating an invalid listing" do
  @listing = listings(:auto_listing_1_jerry)
  patch listing_draft_path(@listing), params: {
    listing: {
      title: @listing.title,
      price: "NaN"
    }
  }
  assert_response :unprocessable_entity
  assert_select "p.is-danger"
  end
end
