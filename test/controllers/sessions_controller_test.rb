require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:jerry)
  end

  test "logging out redirects to the root url and deletes the session" do 
    log_in(@user)

    assert_difference("@user.app_sessions.count", -1) { log_out }
    assert_redirected_to root_path

    follow_redirect!
    assert_select ".notification",
      I18n.t("sessions.destroy.success")
  end

  test "user is logged in and redirected to home with correct creds" do
    assert_difference("@user.app_sessions.count", 1) {
      log_in(@user)
    }

    assert_redirected_to root_path
  end

  test "error is rendered for login with incorrect credentials" do 
    post login_path, params: {
      user: {
        email: "wrong@example.com",
        password: 'password'
      }
    }

    assert_select ".notification", I18n.t("sessions.create.incorrect_details")
  end

  test "user is logged in and redirected to home with correct credentials" do 
    assert_difference("@user.app_sessions.count", 1) {
      post login_path, params: {
        user: {
          email: "jerry@example.com",
          password: "password"
        }
      }
    }
    assert_not_empty cookies[:app_session]
    assert_redirected_to root_path
  end
end