class ClientMobile < ApplicationRecord
	belongs_to :client
	belongs_to :mobile

	accepts_nested_attributes_for :mobile,  reject_if: :all_blank, allow_destroy: true
end
