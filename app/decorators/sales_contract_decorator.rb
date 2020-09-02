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

  def purchase_price
    format_number object.accord.purchase_price
  end

  def all_expenses
    format_number object.accord.expenses.sum(:amount)
  end

  def all_leasing_contract
   sum = 0
   object.accord.leasing_contracts.each  do |a|
    sum = sum + a.payments.sum(:amount).to_f
   end
   format_number sum
  end

  def date_of_signature
    format_date object.accord.date_of_signature
  end
end
