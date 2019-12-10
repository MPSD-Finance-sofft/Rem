class Report 
	def self.colums
		User.filtering_attributes.map{|a,b| [b,a]}
	end
end
