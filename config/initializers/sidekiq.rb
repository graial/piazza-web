if Rails.env.production?
	require "sidekiq/web"
	Sidekiq::Web.use Rack::Auth::Basic do |username, password|
		username_valid =
			ActiveSupport::SecurityUtils.secure_compare(
				::Digest::SHA256.hexdigest(username),
				::Digest::SHA256.hexdigest(
					Rails.application.credentials.sidekiq[:username]
				)
			)
			password_valid =
				ActiveSupport::SecurityUtils.secure_compare(
				::Digest::SHA256.hexdigest(password),
				::Digest::SHA256.hexdigest(
					Rails.application.credentials.sidekiq[:password]
				)
			)
		username_valid & password_valid
	end
end