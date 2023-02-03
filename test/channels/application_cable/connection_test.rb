require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  setup do
    @user = users(:jerry)
  end

  test "can connect when logged in" do
    cookies.encrypted[:app_session] = @user.app_sessions.create.to_h
    connect
    assert_equal @user, connection.user
  end

  test "connection rejected when logged out" do
    assert_reject_connection { connect }
  end
end