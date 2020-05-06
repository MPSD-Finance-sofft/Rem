module PermissionsEnum extend ActiveSupport::Concern

	included do 
		enum kind: [:agent, :manager, :user, :admin, :tipster]
	end
end