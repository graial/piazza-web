require "application_system_test_case"

class PasswordResetsTest < ApplicationSystemTestCase
  setup do 
    @user = users(:jerry)

    ActionMailer::Base.deliveries.clear
  end

  test "can reset password and login" do
    visit login_path

    click_on I18n.t("sessions.new.password_reset")

    fill_in I18n.t("users.password_resets.new.email_label"),
      with: @user.email
    click_on I18n.t("users.password_resets.new.submit")

    assert_text I18n.t("users.password_resets.create.message")

    password_reset_path = extract_primary_link_from_last_mail
    visit password_reset_path

    fill_in User.human_attribute_name(:password), with: "pw"
    click_on I18n.t("users.password_resets.edit.submit")
    assert_selector("p.is-danger")

    fill_in User.human_attribute_name(:password), with: "new-password"
    click_on I18n.t("users.password_resets.edit.submit")

    assert_current_path root_path
  end

  test "existing user can login" do 
    visit root_path

    click_on I18n.t("shared.navbar.login")

    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "wrong"

    click_button I18n.t("sessions.new.submit")
    assert_selector ".notification.is-danger",
      text: I18n.t("sessions.create.incorrect_details")

    fill_in User.human_attribute_name(:email), with: "jerry@example.com"
    fill_in User.human_attribute_name(:password), with: "password"

    click_button I18n.t("sessions.new.submit")

    assert_current_path root_path
    assert_selector ".notification", text: I18n.t("sessions.create.success")
    assert_selector ".navbar-dropdown", visible: false
  end

  test "can update name" do 
    log_in(users(:jerry))

    visit profile_path

    fill_in User.human_attribute_name(:name), with: "Jerry Seinfeld"
    click_button I18n.t("users.show.save_profile")
    assert_selector "form .notification", text: I18n.t("users.update.success")
    assert_selector "#current_user_name", text: "Jerry Seinfeld"
  end
end
