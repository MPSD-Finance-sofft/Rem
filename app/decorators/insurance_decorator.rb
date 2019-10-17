class InsuranceDecorator < ApplicationDecorator
  delegate_all
  
  def date_send
  	format_date(object.date_send)
  end
  
  def date_start
  	format_date(object.date_start)
  end

  def date_of_payment
  	format_date(object.date_of_payment)
  end

  def price 
  	format_number(object.price)
  end
end
