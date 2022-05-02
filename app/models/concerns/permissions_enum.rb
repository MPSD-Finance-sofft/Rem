module PermissionsEnum extend ActiveSupport::Concern

	included do 
		enum kind: [:agent, :manager, :user, :admin, :tipster, :candidate]
	end
end
