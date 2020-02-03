class UserDocument < ApplicationRecord
	has_many_attached :files

	belongs_to :user
	belongs_to :document_type
	after_destroy :removes_files

	def removes_files
		self.files.map{|a| a.purge}
	end

end
