class Address < ApplicationRecord
	def full_name
		"#{self.street.to_s} #{self.number.to_s} #{self.zip.to_s} #{self.village.to_s}, #{self.district.to_s}, #{self.state.to_s}" 
	end
end