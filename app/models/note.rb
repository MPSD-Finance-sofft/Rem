class Note < ApplicationRecord
	include NoteEnum
	belongs_to :accord


	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}

end

