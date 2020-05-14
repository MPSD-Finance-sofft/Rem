class ClientMobile < ApplicationRecord
	belongs_to :client, required: false
	belongs_to :mobile, required: false

	accepts_nested_attributes_for :mobile,  reject_if: :all_blank, allow_destroy: true
end
