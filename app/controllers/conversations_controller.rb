class ConversationsController < ApplicationController
	skip_authorization only: :index
	
	def index
		@conversations = Conversation.current_organization.for_display
	end

	def show
		@message = @conversation.messages.build
	end

	private

	def authorizable_resource
		@conversation = Conversation.find(params[:id])
	end
end