class Notification < ApplicationRecord

	def deactive
		self.active = false 
		self.save
	end

	def object_find
		self.object.constantize.find(self.object_id)
	end

	scope :for_user, -> (user_id) {where(user_id:  user_id)}
	scope :active, -> {where(active:  true)}
	scope :active_state, ->(active) {where(active:  active)}
end
