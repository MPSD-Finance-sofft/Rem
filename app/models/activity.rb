class Activity < ApplicationRecord
	scope :for_user, -> (user_id) {where(user_id:  user_id)} 
end
