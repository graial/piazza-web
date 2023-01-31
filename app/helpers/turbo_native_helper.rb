module TurboNativeHelper
	def turbo_native_bridge_platform
		case request.user_agent
			when /Turbo Native Android/
				"android"
			else
				""
		end
	end

	MAX_INT = 2**30 - 1

	def turbo_native_bridge_element_id(identifier)
puts "bridge element called with identifier: #{identifier}"		
		Zlib.crc32(identifier.to_s) % MAX_INT
	end
end