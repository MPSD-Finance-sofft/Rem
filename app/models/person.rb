class Person < ApplicationRecord
	include PeopleEnum
	validates_with PersonValidator
	has_paper_trail ignore: [:updated_at]
end
