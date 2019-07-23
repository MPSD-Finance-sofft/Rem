class Person < ApplicationRecord
	validates_with PersonValidator
	has_paper_trail ignore: [:updated_at]
end
