class TaxReturnDecorator < ApplicationDecorator
  delegate_all

  def date_send
  	format_date(object.date_send)
  end
  
  def date_send_tax_office
  	format_date(object.date_send_tax_office)
  end

  def tax_pay_date
  	format_date(object.tax_pay_date)
  end

  def price 
  	format_number(object.price)
  end

end
