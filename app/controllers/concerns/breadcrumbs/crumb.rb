class Breadcrumbs::Crumb
	attr_reader :label, :path 

	def initialize(label, path)
		@label = label
		@path = path 
	end

	def to_s 
		"#{label}: #{path}"
	end
end