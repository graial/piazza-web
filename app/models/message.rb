class Message < ApplicationRecord
	include ActionView::RecordIdentifier

	belongs_to :conversation
	belongs_to :from, class_name: "Organization"
	belongs_to :sender, class_name: "User", optional: true

	scope :for_display, -> {
		includes(:from, :sender)
			.where.not(created_at: nil)
			.order(created_at: :asc)
	}

	after_create_commit -> {
		broadcast_append_later_to(
			conversation,
			target: dom_id(conversation, :messages),
			locals: { from: from.id }
		)
	}
end