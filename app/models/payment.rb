class Payment < ApplicationRecord
	has_paper_trail ignore: [:updated_at]
	include RemoveWhiteSpiceFromNumberInput::Amount
	belongs_to :leasing_contract
	has_many :repayment_payment, :dependent => :destroy

	PREPAID = 1
	NORMAL = nil
	PAYMENT_TYPE = [NORMAL, PREPAID]

	def paid?
		to_be_paid == 0
	end

	def to_be_paid
		amount - repayment_payment.sum(:amount)
	end

	def self.not_paid
		select{|a| !a.paid?}
	end

	def self.for_year(year=2020)
		result = {}
		where("payment_date >= ? && payment_date <= ?", "1.1.2020".to_date,"31.12.2020".to_date).select("created_at, month(payment_date) as month, year(payment_date) as year, sum(amount) as amount").group(:month,:year).each do |a|
			result.merge!("#{Date.new(a.year, a.month,1)}": a.amount)
		end
		result
	end
end
