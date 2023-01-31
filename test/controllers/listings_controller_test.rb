require "test_helper"

class ListingsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:jerry)
    log_in @user 
  end

  test "can create a listing" do 
    assert_difference "Listing.count", 1 do       
      post listings_path, params: {
        listing: {
          title: Faker::Commerce.product_name,
          cover_photo: fixture_file_upload("test-image-1.jpg"),
          price: Faker::Commerce.price.floor,
          condition: "mint",
          tags: ["electronics"],
          address_attributes: {
            line_1: "22",
            line_2: "main",
            city: "cangee",
            postcode: "4423"
          }
        }
      }
      
    end

    assert_equal Listing.last.creator, @user
    assert_redirected_to listing_path(Listing.last)
  end

  test "error when creating an invalid listing" do 
    assert_no_difference "Listing.count" do 
      post listings_path, params: {
        listing: {
          title: "title",
          price: 300,
          condition: "mint",
          tags: ["electronics"]
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger"
  end
   
  test "error when creating a listing with no tags" do 
    assert_no_difference "Listing.count" do 
      post listings_path, params: {
        listing: {
          title: Faker::Commerce.product_name,
          price: Faker::Commerce.price.floor,
          condition: "mint"
        }
      }
    end

    assert_select "label[for='listing_tags'] ~ p.is-danger"
  end

  test "can update a listing" do 
    @listing = listings(:auto_listing_1_jerry)
    new_title = Faker::Commerce.product_name
    
    patch listing_path(@listing), params: {
      listing: {
        title: new_title,
        price: @listing.price,
        tags: ["electronics"]
      }
    }

    assert_redirected_to listing_path(@listing)
    assert_equal new_title, @listing.reload.title
  end


  test "error when updating a listing with invalid data" do 
    @listing = listings(:auto_listing_1_jerry)
    patch listing_path(@listing), params: {
      listing: {
        title: @listing.title,
        price: "NaN"
      }
    }

    assert_response :unprocessable_entity
  end

  test "can delete a listing" do 
    @listing = listings(:auto_listing_1_jerry)

    assert_difference "Listing.count", -1 do 
      delete listing_path(@listing)
    end

    assert_redirected_to my_listings_path
  end
end