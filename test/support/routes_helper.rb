module RoutesHelpers
	def draw_test_routes(&block)
		# Don't clear routes when calling `Rails.application.routes.draw`
		Rails.application.routes.disable_clear_and_finalize = true 

		Rails.application.routes.draw do 
			scope "test" do 
				instance_exec(&block)
			end
		end
	end

	def reload_routes!
		Rails.application.reload_routes!
	end
end