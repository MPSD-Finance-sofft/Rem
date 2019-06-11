module AccordsClientEnum extend ActiveSupport::Concern
	
	included do 
		enum relationship: [:owner, :applicant, :tenant]
	end
end