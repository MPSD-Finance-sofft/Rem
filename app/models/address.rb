class Address < ApplicationRecord
	def full_name
		"#{self.street.to_s} #{self.number.to_s} , #{self.zip.to_s} #{self.village.to_s} okr.:#{self.district.to_s}"
	end
end