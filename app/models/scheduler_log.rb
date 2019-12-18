class SchedulerLog < ApplicationRecord


	def list_arr
		self.list.scan(/\d+/).map(&:to_i)
	end
end
