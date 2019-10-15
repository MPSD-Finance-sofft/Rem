class Note < ApplicationRecord
	include NoteEnum
	belongs_to :accord

	before_save :ad_default_color

	def ad_default_color
		if self.color.blank?
			self.color = "#ff8c82" if permission == "agent"
			self.color = "#fff86b" if permission == "manager"
			self.color = "#96d35f" if permission == "user"
		end
	end

	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}

end