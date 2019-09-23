class EventType < ApplicationRecord

	def self.all_description_for_select
		EventType.pluck(:description).map{|a| [a,a]}
	end
end
