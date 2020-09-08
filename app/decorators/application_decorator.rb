class ApplicationDecorator < Draper::Decorator
  include ActionView::Helpers::NumberHelper

  def format_date(date) 
  	date.strftime('%d.%m.%Y') unless date.blank?
  end

  def created_at
 		format_date(object.created_at)
	end

 def updated_at
    format_date_time(object.updated_at)
  end

  def format_number(number)
    number_to_currency(number, unit: "Kč", separator: ",", delimiter: " ", format: "%n %u",  precision: 0)
  end

  def format_date_time(date)
    date.strftime('%d.%m.%Y %T') unless date.blank?
  end

  def month_to_czech_text(month_number)
      case month_number
        when 1
          'Leden' 
        when 2
          'Únor' 
        when 3
          'Březen' 
        when 4
          'Duben'
        when 5
          'Květen'
        when 6
          'Červen'
        when 7
          'Červenec'
        when 8
          'Srpen'
        when 9
          'Září'
        when 10
          'Říjen'
        when 11
          'Listopad'
        when 12
          'Prosinec'
      end
  end

end
