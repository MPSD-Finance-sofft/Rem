class Report 
	def self.colums
		User.filtering_attributes.map{|a| [a,a]}
	end
end
