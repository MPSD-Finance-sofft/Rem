class VersionDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def whodunnit
  	all_name = User.find_by_id(object.whodunnit).try(:all_name)
  	all_name ? all_name : 'systém'
  end

 def created_at
  	format_date_time object.created_at
  end
end
