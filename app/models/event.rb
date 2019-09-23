class Event < ApplicationRecord
	validates :title, presence: true
  	attr_accessor :date_range

  	def all_day_event?
    	self.start == self.start.midnight && self.end == self.end.midnight ? true : false
  	end

	scope :for_user, -> (user_id) {where(user_id:  user_id)} 
end
