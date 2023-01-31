class UserMailer < ApplicationMailer
	before_action { @user = params[:user] }

	default to: -> { %("#{@user.name}" <#{@user.email}>) }

	def password_reset(id)
		@password_reset_id = id

		mail subject: t(".subject")
	end
end