class Board < ApplicationRecord



	def self.show_by_permission(permission)
		return 	Board.all if permission == "admin" || permission == "user"
		return 	Board.for_manager if permission == "manager" 
		return 	Board.for_permmision("agent") if permission == "agent" 
	end

	scope :for_permmision, -> (permision) {where(permision: permision)}
	scope :for_manager, ->  {where(permision: ["manager", "agent"])}

end
