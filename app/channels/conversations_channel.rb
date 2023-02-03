class ConversationsChannel < ApplicationCable::Channel
	extend Turbo::Streams::StreamName
	include Turbo::Streams::StreamName::ClassMethods

	def subscribed
		if conversation&.show?(organization)
			stream_from stream_name
		else 
			reject
		end
	end

	private

	def stream_name
		@stream_name ||= verified_stream_name_from_params
	end

	def conversation
		@conversation ||= GlobalID::Locator.locate(stream_name)
	end
end