module Versions::Base
	def attribut_changes(attribute)
		self.versions.select{|a| a.object_changes && a.object_changes.include?(attribute)}.map{|a| [a.whodunnit, a.changeset[attribute], a.created_at]}
	end

	def object_attributes_time_changes(attribute)
		a = self.versions.select{|a| a.object_changes && a.object_changes.include?(attribute)}
		result = []
		a.each do |b|
			result <<  {state: b.changeset[attribute].last, created_at: b.created_at}
		end
	end

	def object_attributes_valuee_in_between(arr, attribute)
		if arr.blank?
			first_date = '1.1.1991'.to_date
			last_date = '1.1.2991'.to_date
		else
			first_date = arr.first.to_date
			last_date = arr.last.to_date
		end
		result = object_attributes_time_changes(attribute).select{|a| a.created_at <= last_date + 1.day && a.created_at >= first_date}.map{|a| a.changeset[attribute].last}
		result
	end
end
