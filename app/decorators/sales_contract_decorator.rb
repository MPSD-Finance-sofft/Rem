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
    format_number object.purchase_price
  end

  def all_expenses
    format_number object.expenses_by_realty
  end

  def all_leasing_contract
   format_number object_all_leasig_contract
  end

  def object_all_leasig_contract
    sum = 0
    object.realty.leasing_contracts.each  do |a|
      sum = sum + a.payments.sum(:amount).to_f
    end
    sum
  end

  def date_of_signature
    format_date object.accord.date_of_signature
  end

  def days
    (object.date_of_sale_realty - object.accord.date_of_signature).to_i
  end

  def profit
    format_number profit_object
  end

  def profit_object
    object.amount - object.purchase_price - object.expenses_by_realty + object_all_leasig_contract - object_sum_energies - object_svj
  end

  def income
    ((profit_object / object.purchase_price) * 100).round(2).to_s + "%"
  end

  def object_sum_energies
    object.accord.energies.sum(:price)
  end

  def sum_energies
    format_number object_sum_energies
  end

  def object_svj
    object.accord.month_advences.sum(:price)
  end

  def svj
    format_number object_svj
  end

  def pa
    (((profit_object / object.purchase_price) * 100).round(2)/days * 365).round(2).to_s + "%"
  end

end
