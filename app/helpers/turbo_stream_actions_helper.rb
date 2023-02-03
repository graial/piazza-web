module TurboStreamActionsHelper
	def switch_class(target, className)
		turbo_stream_action_tag(
			:switch_class,
			target: target,
			class: className
		)
	end
end

Turbo::Streams::TagBuilder.prepend(TurboStreamActionsHelper)