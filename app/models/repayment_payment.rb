class RepaymentPayment < ApplicationRecord
	belongs_to :repayment
	belongs_to :payment
end
