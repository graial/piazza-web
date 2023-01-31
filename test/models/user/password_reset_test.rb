require "test_helper"

class User::PasswordResetTest < ActiveSupport::TestCase
	include ActionMailer::TestHelper

	setup do 
		@user = users(:jerry)
		ActionMailer::Base.deliveries.clear
	end

	test "resetting a user's password destroys all sessions and sends reset email" do 
		@user.app_sessions.create
		@user.app_sessions.create

		@user.reset_password

		assert_emails 1
		assert_empty @user.app_sessions
		assert_not_nil @user.password_reset_token
	end

	test "can retrieve a password with a valid password reset id" do 
		@user.reset_password
		password_reset_id = @user.send(:password_reset_id)

		user = User.find_by_password_reset_id(password_reset_id)

		assert_equal @user, user
	end

	test "retrieving a user with an invalid id returns nil" do 
		assert_nil User.find_by_password_reset_id("invalid")
	end

	test "retrieving a user with an expired id returns nil" do 
		@user.reset_password
		password_reset_id = @user.send(:password_reset_id)

		travel_to 3.hours.from_now

		assert_nil User.find_by_password_reset_id(password_reset_id)
	end

	test "updating the password nullifies the password reset token" do 
		@user.reset_password
		assert_not_nil @user.reload.password_reset_token_digest

		@user.update(password: "new_password")

		assert_nil @user.reload.password_reset_token_digest
	end
end