class FileBoard < ApplicationRecord
	has_one_attached :file

	def self.show_by_permission(permission)
		return 	FileBoard.all if permission == "admin" || permission == "user"
		return 	FileBoard.for_manager if permission == "manager"
		return 	FileBoard.for_agent if permission == "agent"
    return  FileBoard.for_permmision("tipster") if permission == "tipster"
	end

	enum permission: [:agent, :manager, :user, :admin, :tipster]


	scope :for_manager, ->  {where(permission: ["agent","manager", "tipster"])}
  scope :for_agent, ->  {where(permission: ["agent","tipster"])}
	scope :validity, -> {where("start <= ? AND end >= ?", Date.today,Date.today)}
	scope :for_permmision, -> (permision) {where(permission: permision)}
end

