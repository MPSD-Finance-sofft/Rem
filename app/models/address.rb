class Address < ApplicationRecord
	has_one :user_address
	def full_name
		"#{self.street.to_s} #{self.number.to_s} #{self.ev_number.to_s}, #{self.zip.to_s} #{self.village.to_s}, okr. #{self.district.to_s}"
	end

	def index_name
		"#{self.street.to_s} #{self.number.to_s} #{self.ev_number.to_s}, #{self.zip.to_s} #{self.village.to_s}"
	end

	def number
		number = self.attributes["number"]
		if number.split("/").size != 2
			number.delete("/")
		else
			number
		end unless number.blank?
	end

	def zip
		zip = self.attributes["zip"]
		zip.insert(3, " ") if !zip.blank? && zip.size >= 3
	end
end