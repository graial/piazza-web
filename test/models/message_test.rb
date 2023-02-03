require "test_helper"

class MessageTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper, ActionCable::TestHelper

  setup do
    @user = users(:jerry)
    @organization = organizations(:jerry)
    @conversation = conversations(:kramer_jerry_1)
    Current.organization = @organization
  end

  test "broadcasts partial after creation" do
    @conversation.messages.create(
      from: @organization,
      sender: @user,
      body: "Ahoy"
    )
    
    perform_enqueued_jobs
    assert_broadcasts stream_name, 1
  end

  private
  
  def signed_stream_name
    @signed_stream_name ||= ConversationsChannel.signed_stream_name(@conversation)
  end

  def stream_name
    @stream_name ||= ConversationsChannel.verified_stream_name(signed_stream_name)
  end
end