require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  setup do 
    @user = users(:jerry)
    ActionMailer::Base.deliveries.clear 
  end

  test "password reset" do 
    email = UserMailer
                .with(user: @user)
                .password_reset
                .deliver_now

    assert_match @user.name, email[:to].unparser_value
    assert_match @user.email, email[:to].unparser_value

    assert_select_email do 
      assert_select "a.button"
    end
  end
end
