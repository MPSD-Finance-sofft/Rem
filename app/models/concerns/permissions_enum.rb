module PermissionsEnum extend ActiveSupport::Concern
	
	included do 
		enum kind: [:admin, :user, :agent, :manager]
	end
end