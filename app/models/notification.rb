class Notification < ApplicationRecord

	def deactive
		self.active = false 
		#self.save
	end

	scope :for_user, -> (user_id) {where(user_id:  user_id)}
	scope :active, -> {where(active:  true)}
end
