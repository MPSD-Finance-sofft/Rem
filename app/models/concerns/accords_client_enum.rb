module AccordsClientEnum extend ActiveSupport::Concern
	
	included do 
		enum relationship: [:owner, :applicant, :tenant, :new_owner]
	end
end