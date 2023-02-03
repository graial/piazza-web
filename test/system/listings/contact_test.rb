require "application_system_test_case"

class ContactTest < ApplicationSystemTestCase
  setup do 
    @user = users(:jerry)
    @listing = listings(:auto_listing_1_kramer)

    log_in(@user)
  end

  test "can contact seller" do
    visit listing_path(@listing)

    click_on I18n.t("listings.show.contact")
    assert_selector ".modal.is-active"
  end

  test "cannot see contact button for own ad" do
    @listing = listings(:auto_listing_1_jerry)

    visit listing_path(@listing)
    assert_no_select ".button[href=#{listing_contact_path(@listing)}"
  end
end
