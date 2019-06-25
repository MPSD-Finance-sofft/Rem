class UserAddress < ApplicationRecord
	belongs_to :user
	belongs_to :address

	include UserAddressEnum
	accepts_nested_attributes_for :address,  reject_if: :all_blank, allow_destroy: true

end
