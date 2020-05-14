class ClientEmail < ApplicationRecord
	belongs_to :client, required: false
	belongs_to :email, required: false

	accepts_nested_attributes_for :email,  reject_if: :all_blank, allow_destroy: true
end
