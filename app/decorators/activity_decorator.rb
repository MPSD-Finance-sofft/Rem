class ActivityDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def created_at
 		format_date_time(object.created_at)
	end

  def user
    return object.user.try(:all_name) if object.true_user.nil?
    object.user.try(:all_name).to_s + "(#{object.true_user.try(:username)})"
  end
end
