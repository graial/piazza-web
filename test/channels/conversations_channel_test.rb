require "test_helper"
class ConversationsChannelTest < ActionCable::Channel::TestCase
	setup do
		@user = users(:jerry)
		@organization = organizations(:jerry)
		@conversation = conversations(:kramer_jerry_1)

		stub_connection(
			user: users(:jerry),
			organization: organizations(:jerry)
		)
	end

	test "can subscribe" do
		@conversation = conversations(:kramer_jerry_1)
		subscribe signed_stream_name: signed_stream_name
		assert subscription.confirmed?
		assert_has_stream stream_name
	end

	test "cannot subscribe to others' conversations" do
		@conversation = conversations(:elaine_george_1)
		subscribe signed_stream_name: signed_stream_name
		assert_not subscription.confirmed?
		assert_no_streams
	end

	test "updates conversation's online participants" do
		subscribe signed_stream_name: signed_stream_name
		assert(
			@conversation.online_participants.include?(@organization.id)
		)

		unsubscribe
		assert_not(
			@conversation.online_participants.include?(@organization.id)
		)
	end
	
	private
	
	def signed_stream_name
		@signed_stream_name ||= ConversationsChannel.signed_stream_name(@conversation)
	end

	def stream_name
		@stream_name ||= ConversationsChannel.verified_stream_name(signed_stream_name)
	end
end