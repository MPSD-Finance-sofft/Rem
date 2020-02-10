class Payment < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
	has_many :repayment_payment, :dependent => :destroy

	def paid?
		to_be_paid == 0
	end

	def to_be_paid
		amount - repayment_payment.sum(:amount)
	end

	def self.not_paid
		select{|a| !a.paid?}
	end
end
