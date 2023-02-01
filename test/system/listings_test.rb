require "application_system_test_case"

class ListingsTest < ApplicationSystemTestCase
  setup do
    @user = users(:jerry)
    log_in(@user)
  end

  test "can create a listing" do
    click_on I18n.t("shared.navbar.create_ad")

    fill_in Listing.human_attribute_name(:title),
      with: "Coffee table book about coffee tables"
    fill_in Listing.human_attribute_name(:price),
      with: "99"

    select Listing.human_enum_name(:condition, :used),
      from: Listing.human_attribute_name(:condition)

    find("[data-tags-target='input']").set("book")
    click_on I18n.t("listings.tags_field.add_tag")
    find("[data-tags-target='input']").set("hardcover")
    click_on I18n.t("listings.tags_field.add_tag")

    assert_selector "ui-tag", count: 2

    fill_in Address.human_attribute_name(:line_1), with: "123"
    fill_in Address.human_attribute_name(:line_2), with: "Fake Street"
    fill_in Address.human_attribute_name(:city), with: "London"
    fill_in Address.human_attribute_name(:postcode), with: "W1 1AB"

    fill_in_rich_text_area Listing.human_attribute_name(:description), 
      with: 
        "This is a story that must be told -
        A history of coffee tables, celebrities,
        and their coffee tables..."

    find("[data-image-upload-target='fileInput']", visible: false)
        .attach_file(file_fixture("test-image-1.jpg"))
    click_on I18n.t("listings.new.publish")

    assert_selector ".notification"
    assert_current_path listing_path(Listing.last)
  end

  test "can update a listing" do 
    visit my_listings_path

    find(".card", match: :first).click

    click_on I18n.t("listings.show.edit")

    fill_in Listing.human_attribute_name(:title),
      with: "Coffee table book about coffee tables"

    click_on I18n.t("listings.edit.publish")

    assert_selector ".notification"
  end

  test "can delete a listing" do 
    visit my_listings_path

    find(".card", match: :first).click

    click_on I18n.t("listings.show.edit")

    accept_confirm do
      click_on I18n.t("listings.edit.delete")
    end

    assert_selector ".notification"
    assert_current_path my_listings_path
  end

  test "can delete and reselect image" do
    visit my_listings_path

    find(".card", match: :first).click
    click_on I18n.t("listings.show.edit")
    
    click_on I18n.t("shared.image_field.remove_image")
    assert_selector "button",
      text: I18n.t("shared.image_field.remove_image"),
      visible: false
    
    find("[data-image-upload-target='fileInput']", visible: false)
      .attach_file(file_fixture("test-image-1.jpg"))
    
    assert_selector "img"
  end

  test "shows error for tags when out of range" do
    visit my_listings_path
    
    find(".card", match: :first).click
    click_on I18n.t("listings.show.edit")
    
    find("[data-tags-target='input']")
      .set("coffee")
    click_on I18n.t("listings.tags_field.add_tag")
    
    find("[data-tags-target='input']")
      .set("table")
    click_on I18n.t("listings.tags_field.add_tag")
    assert_selector "ui-tag", count: 6
    
    click_on I18n.t("listings.edit.publish")
    assert_selector "label[for='listing_tags'] ~ p.is-danger"
    6.times do
      find("ui-tag", match: :first)
        .find("a.is-delete").click
      end
    assert_no_selector "ui-tag"
    click_on I18n.t("listings.edit.publish")

    assert_selector "label[for='listing_tags'] ~ p.is-danger"
  end
end