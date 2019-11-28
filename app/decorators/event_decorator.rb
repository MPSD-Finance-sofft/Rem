class EventDecorator < ApplicationDecorator
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
      format_date_time object.created_at
    end

    def creator
      object.creator.try(:all_name)
    end

    def user
      object.user.try(:all_name)
    end

    def start_date
       format_date_time object.start
    end

    def end_date
       format_date_time object.end
    end
end
