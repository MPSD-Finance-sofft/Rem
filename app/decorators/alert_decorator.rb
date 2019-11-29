class AlertDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def object_to_s
  	'Pro žádost ' + object.object_id.to_s
  end

  def creator
    object.creator.try(:all_name)
  end

  def object_id
    object.object_id
  end

  def alert_type
    object.alert_type.try(:description)
  end 
end
