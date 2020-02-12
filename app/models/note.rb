class Note < ApplicationRecord
	include NoteEnum
	belongs_to :accord

	before_save :ad_default_color
	after_save :add_notification


	def ad_default_color
		if self.color.blank?
			self.color = "Yellow" if permission == "agent"
			self.color = "Aqua" if permission == "manager"
			self.color = "Fuchsia" if permission == "user"
		end
	end

	def add_notification
		Notification::for_notice_accord(self.accord_id,self.decorate)
	end

	scope :for_agent, ->  {where(permission: "agent")}
	scope :for_manager, ->  {where(permission: ["agent","manager"])}
	scope :for_accord, -> (accord_id) {where(accord_id: accord_id)}
	scope :user_id, -> (user_id) {where(user_id: user_id)}

end