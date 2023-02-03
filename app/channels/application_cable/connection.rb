module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user, :organization

    def connect
      app_session = authenticate_session
      reject_unauthorized_connection unless app_session.present?

      self.user = app_session.user 
      self.organization = user.organizations.first
    end

    private

    def authenticate_session
      user_data = cookies.encrypted[:app_session]&.with_indifferent_access
      user_data => { user_id:, app_session:, token: }

      user = User.find(user_id)
      user.authenticate_app_session(app_session, token)
    rescue
      reject_unauthorized_connection
    end
  end
end