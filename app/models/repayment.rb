class Repayment < ApplicationRecord
	has_paper_trail ignore: [:updated_at, :id]
	include RepaymentEnum
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
	belongs_to :repayment_type, class_name: "RepaymetType", foreign_key:"repayment_type_id", required: false
	has_many :repayment_payment
	attr_accessor :paid

	before_create :amount_from_repayment_type

	def for_year?(year)
		self.repayment_date.try(:year) == year
	end

	def amount_from_repayment_type
		unless self.repayment_type.blank?
			procent = self.repayment_type.try(:procent).to_f
			number = self.repayment_type.try(:number).to_f
			self.amount = self.leasing_contract.monthly_rent * procent / 100 + number
		end
	end

	def paid?
		missing_to_pay == 0
	end

	def missing_to_pay
		amount - repayment_payment.sum(:amount).to_f
	end

	def self.not_paid
		select{|a| !a.paid?}
	end

	scope :for_leasing_contract, -> (leasing_contract_id) {where(leasing_contract_id:  leasing_contract_id)}
	scope :repayment_date_today, -> {where("repayment_date < ?",Date.today)}
end
