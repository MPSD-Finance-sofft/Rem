class SalesContractDecorator < ApplicationDecorator
  delegate_all
  def date_of_receipt_of_payment
    format_date object.date_of_receipt_of_payment
  end

  def date_of_sale_realty
    format_date object.date_of_sale_realty
  end

  def amount
    format_number object.amount
  end

  def user
    object.user.try(:all_name)
  end
end
