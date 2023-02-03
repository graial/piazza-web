require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    @conversation = conversations(:kramer_jerry_1)
    log_in @user
  end

  test "shows dual pane index on desktop" do
    get conversations_path
    assert_response :ok
    assert_select "#conversations"
    assert_select "turbo-frame#conversation"
  end
  
  test "can view messages for a conversation" do
    get conversation_path(@conversation)
    assert_response :ok
    assert_select "##{dom_id(@conversation, :messages)}"
  end
end
