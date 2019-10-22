class UserEmail < ApplicationRecord
	belongs_to :user
	belongs_to :email

	accepts_nested_attributes_for :email,  reject_if: :all_blank, allow_destroy: true
end
