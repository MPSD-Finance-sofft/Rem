class PaymentDecorator < ApplicationDecorator
  delegate_all

  	def payment_date
		format_date(object.payment_date)
	end

	def amount
		format_number(object.amount)
	end

	def sel_kind
		Payment::PAYMENT_TYPE.map{|a| [kind_to_s(a),a]}
	end

	def kind_to_s(kind)
		case kind
		when nil
			'Normální'
		when Payment::PREPAID
			'Předplacená'
		end
	end

	def kind
		kind_to_s(object.kind)
	end

  def object_kind
    object.kind
  end

end
