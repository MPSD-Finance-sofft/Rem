class UserDocument < ApplicationRecord
	has_many_attached :files

	belongs_to :user
	belongs_to :document_type
end
