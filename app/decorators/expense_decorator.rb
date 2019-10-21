class ExpenseDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
	def expense_type
 		object.expense_type.try(:name)
 	end

  def payout_day
    format_date object.payout_day
  end

  def date_of_excepted_payment
    format_date object.date_of_excepted_payment
  end

  def amount
    format_number object.amount
  end

  def real_amount
    format_number object.real_amount
  end
end
