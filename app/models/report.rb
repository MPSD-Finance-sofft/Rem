class Report
	def self.colums(user)
		Report::colums_for_user_perrmision(user).map{|a,b| [b,a]}
	end

	def self.colums_for_user_perrmision(user)
		if user.admin?
			User.filtering_attributes_agent + User.filtering_attributes_manager + User.filtering_attributes
		elsif user.manager?
			User.filtering_attributes_manager
		else
			User.filtering_attributes_agent 
		end
	end
end
