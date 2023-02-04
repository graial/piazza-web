module Conversation::Notifier
	extend ActiveSupport::Concern

	included do 
		kredis_set :online_participants, typed: :integer 
	end
end