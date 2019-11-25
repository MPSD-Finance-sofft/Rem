class Repayment < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	include RepaymentEnum
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
	belongs_to :repayment_type, class_name: "RepaymetType", foreign_key:"repayment_type_id", required: false
	attr_accessor :paid


	def for_year?(year)
		self.repayment_date.try(:year) == year
	end

	scope :for_leasing_contract, -> (leasing_contract_id) {where(leasing_contract_id:  leasing_contract_id)}
	scope :repayment_date_today, -> {where("repayment_date < ?",Date.today)}
end
