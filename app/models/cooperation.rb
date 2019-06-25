class Cooperation < ApplicationRecord
	belongs_to :or_request, class_name: "User", :dependent => :destroy
	belongs_to :type_of_notice

	validates :date_of_notice, :day_count, presence: true

	def runing_notice?
		Date.today < self.date_lost_cooperation
	end

	def date_lost_cooperation
		self.date_of_notice  + self.day_count
	end

	def lost_cooperation?
		Date.today > self.date_lost_cooperation
	end

end
