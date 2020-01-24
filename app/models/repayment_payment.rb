class RepaymentPayment < ApplicationRecord
	belongs_to :repayment
	belongs_to :payment
	has_many :repayment_payment
end
