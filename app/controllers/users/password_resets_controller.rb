class Users::PasswordResetsController < ApplicationController
	before_action :load_user, only: [:edit, :update]
	skip_authentication

	def new
	end

	def create
		User.find_by(email: params[:email])&.reset_password
	end

	def edit
	end

	def update
		@user.assign_attributes(password_reset_params)
		if @user.save(context: :password_change)
			@app_session = @user.app_sessions.create
			log_in(@app_session)

			redirect_to root_path,
				status: :see_other,
				flash: { success: t(".success") }
		else
			render :edit, status: :unprocessable_entity
		end
	end

	private

	def load_user
		@user = User.find_by_password_reset_id(params[:id])

		redirect_to new_users_password_reset_path,
			status: :see_other,
			flash: {
				error: t("users.password_resets.invalid_link")
			} unless @user.present?
	end

	def password_reset_params
		params.require(:user).permit(:password)
	end
end
