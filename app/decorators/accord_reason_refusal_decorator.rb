class AccordReasonRefusalDecorator < ApplicationDecorator
  delegate_all

  def created_at
  	format_date object.created_at
  end

  def creator
  	object.creator.try(:all_name)
  end

  def reason_refusal_type
  	object.reason_refusal_type.try(:description)
  end

end