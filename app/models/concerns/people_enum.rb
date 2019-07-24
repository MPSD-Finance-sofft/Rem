module PeopleEnum extend ActiveSupport::Concern
	
	included do 
		enum marital_status: [:divorced, :married, :widow, :single, :mate]
	end
end