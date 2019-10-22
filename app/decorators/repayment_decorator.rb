class RepaymentDecorator < ApplicationDecorator
  delegate_all

	def repayment_date
		format_date(object.repayment_date)
	end

	def amount
		format_number(object.amount)
	end
	
end
