class MessagesController < ApplicationController
  before_action :load_conversation
  before_action -> { authorize! @conversation.can_message? }
  
  def create
    @message = @conversation.messages.build(
      message_params.with_defaults(
        from: Current.organization,
        sender: Current.user
      )
    )

    @message.save
  end

  private 

  def message_params
    params.require(:message).permit(:body)
  end

  def load_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end