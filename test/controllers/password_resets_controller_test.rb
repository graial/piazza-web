require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  setup do 
    @user = users(:jerry)
    
    ActionMailer::Base.deliveries.clear
  end

  test "creating a password reset sends an email and shows instructions" do 
    post users_password_resets_path, params: { 
      email: @user.email
    }
    
    assert_response :ok
    assert_select "p",
      text: I18n.t("users.password_resets.create.message")
    assert_emails 1
  end

  test "accessing the password reset page with a valid id shows the form" do 
    @user.reset_password
    get edit_users_password_reset_path(
      CGI.escape(@user.send(:password_reset_id))
    )

    assert_response :ok
    assert_select "form"
  end

  test "accessing the password reset page with an invalid or nil id redirects" do 
    get edit_users_password_reset_path("invalid")
    assert_redirected_to new_users_password_reset_path
    get edit_users_password_reset_path
    assert_redirected_to new_users_password_reset_path
  end

  test "resetting a password logs in and redirects the user to the root" do 
    @user.reset_password
    password_reset_id = CGI.escape(@user.send(:password_reset_id))

    patch users_password_reset_path(password_reset_id), params: {
      user: {
        password: "W3lcome?"
      }
    }

    assert_redirected_to root_path
    follow_redirect!
    assert_response :ok 

    assert @user.reload.authenticate("W3lcome?")
  end

  test "entering a password that's too short renders an error" do 
    @user.reset_password
    password_reset_id = CGI.escape(@user.send(:password_reset_id))

    patch users_password_reset_path(password_reset_id),params: {
      user: {
        password: "pw"
      }
    }

    assert_response :unprocessable_entity
    assert_select "p.is-danger"
  end
end
