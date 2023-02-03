require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
    @conversation = conversations(:kramer_jerry_1)
    log_in @user
  end

  test "creates message and sends blank response" do
    message_body = "These pretzels are making me thirsty"
    assert_difference "@conversation.messages.count", 1 do
      post conversation_messages_path(@conversation), params: {
        message: {
          body: message_body
        }
      }, headers: {
        accept: "text/vnd.turbo-stream.html"
      }
    end

    assert_response :no_content
  end

  test "cannot send message to unauthorized conversation" do
    @conversation = conversations(:elaine_george_1)
    
    post conversation_messages_path(@conversation), params: {
      message: {
        body: ""
      }
    }

    assert_response :forbidden
  end
end