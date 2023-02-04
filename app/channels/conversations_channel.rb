class ConversationsChannel < ApplicationCable::Channel
	extend Turbo::Streams::StreamName
	include Turbo::Streams::StreamName::ClassMethods

	def subscribed
		if conversation&.show?(organization)
			stream_from stream_name
			conversation.online_participants.add(organization.id)
		else 
			reject
		end
	end

	def unsubscribed
		conversation.online_participants.remove(organization.id)
	end

	private

	def stream_name
		@stream_name ||= verified_stream_name_from_params
	end

	def conversation
		@conversation ||= GlobalID::Locator.locate(stream_name)
	end
end