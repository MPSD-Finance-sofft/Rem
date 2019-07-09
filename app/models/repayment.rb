class Repayment < ApplicationRecord
	belongs_to :leasing_contract


	scope :for_leasing_contract, -> (leasing_contract_id) {where(leasing_contract_id:  leasing_contract_id)}
end
