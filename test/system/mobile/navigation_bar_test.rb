require "application_system_test_case"

class NavBarTest < MobileSystemTestCase
  test "new access sign up page via burger menu" do
    visit root_path

    find(".navbar-burger").click
    click_on I18n.t("shared.navbar.sign_up")

    assert_current_path sign_up_path
  end

  test "can access login page via burger menu" do 
    visit root_path

    find(".navbar-burger").click
    click_on I18n.t("shared.navbar.login")

    assert_current_path login_path
  end
end
