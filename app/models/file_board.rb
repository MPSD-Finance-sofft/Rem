class FileBoard < ApplicationRecord
	has_attached_file :file
	do_not_validate_attachment_file_type :file

	def self.show_by_permission(permission)
		return 	FileBoard.all if permission == "admin" || permission == "user"
		return 	FileBoard.for_manager if permission == "manager" 
		return 	FileBoard.for_permmision("agent") if permission == "agent" 
	end

	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
end

