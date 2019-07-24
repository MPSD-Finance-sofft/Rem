class Upload < ApplicationRecord
	has_attached_file :file
	do_not_validate_attachment_file_type :file
	belongs_to :accord



	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
end