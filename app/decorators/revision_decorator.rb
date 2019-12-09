class RevisionDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def valididity_from_report
  	format_date object.valididity_from_report
  end
  
  def expiration_report
	 format_date object.expiration_report
  end
 
  def delivery_report
	 format_date object.delivery_report
  end

  def amount
	 format_number object.amount
  end

  def datecontrol
   format_date object.datecontrol
  end

  def revision_type
    object.revision_type.try(:description)
  end

  def user
    object.user.try(:all_name)
  end
end
