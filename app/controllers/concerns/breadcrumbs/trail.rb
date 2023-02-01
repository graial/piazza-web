class Breadcrumbs::Trail
	def initialize 
		@breadcrumbs = []
	end

	def show?
		@breadcrumbs.count > 0
	end

	def tail
		@breadcrumbs.take(@breadcrumbs.size - 1)
	end

	def head
		@breadcrumbs.last 
	end

	def method_missing(method, *args)
		@breadcrumbs.send(method, *args)
	end
end