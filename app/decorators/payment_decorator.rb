class PaymentDecorator < ApplicationDecorator
  delegate_all

  	def payment_date
		format_date(object.payment_date)
	end
	
	def amount
		format_number(object.amount)
	end

end
