class Alert < ApplicationRecord
	belongs_to :creator, class_name: "User", foreign_key: 'creator_id'
    belongs_to :user, class_name: "User", foreign_key: 'user_id'
	belongs_to :alert_type


	def object_find
		self.object.constantize.find(self.object_id)
	end
	
	scope :for_user, -> (user_id) {where(user_id:  user_id)}
	scope :active, -> {where(done:  false).where('date_alert <= ?', Date.today)}
	scope :done_state, ->(done) {where(done:  done)}
end
