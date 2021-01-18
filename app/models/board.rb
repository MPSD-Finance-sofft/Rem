class Board < ApplicationRecord



	def self.show_by_permission(permission)
		return 	Board.all if permission == "admin" || permission == "user"
		return 	Board.for_manager if permission == "manager"
		return 	Board.for_agent if permission == "agent"
    return  Board.for_permmision("tipster") if permission == "tipster"
	end

	scope :for_permmision, -> (permision) {where(permission: permision)}
	scope :for_manager, ->  {where(permission: ["manager", "agent", "tipster"])}
  scope :for_agent, ->  {where(permission: ["agent", "tipster"])}
	scope :validity, -> {where("date <= ? AND ( end_date >= ? OR end_date IS NULL)", Date.today,Date.today)}

end
