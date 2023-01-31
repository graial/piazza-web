class UserMailer < ApplicationMailer
	before_action { @user = params[:user] }

	default to: -> { %("#{@user.name}" <#{@user.email}>) }

	def password_reset
		mail subject: t(".subject")
	end
end