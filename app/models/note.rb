class Note < ApplicationRecord
	include NoteEnum
	belongs_to :accord
  belongs_to :user

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
  scope :accord_id, -> (accord_id) {where(accord_id: accord_id)}
  scope :accord_state, -> (accord_state) {joins(:accord).where("accords.state": accord_state)}
  scope :description, -> (description) {where("description LIKE ?", "%#{description}%")}
end
