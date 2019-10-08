class FileBoard < ApplicationRecord


	def self.show_by_permission(permission)
		return 	FileBoard.all if permission == "admin" || permission == "user"
		return 	FileBoard.for_manager if permission == "manager" 
		return 	FileBoard.for_permmision("agent") if permission == "agent" 
	end

	enum permission: [:agent, :manager, :user, :admin]


	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
	scope :validity, -> {where("start < ? AND end > ?", Date.today,Date.today)}
	scope :for_permmision, -> (permision) {where(permission: permision)}
end

