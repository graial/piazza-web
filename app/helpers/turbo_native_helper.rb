module TurboNativeHelper
	def turbo_native_bridge_platform
		case request.user_agent
			when /Turbo Native Android/
				"android"
			else
				""
		end
	end
end