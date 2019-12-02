class PlannedPriceDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def user
    object.user.try(:all_name)
 	end

  def advertising_price
    format_number(object.advertising_price)
  end

  def market_price
    format_number(object.market_price)
  end

  def estimated_selling_price
    format_number(object.estimated_selling_price)
  end

  def real_price
    format_number(object.real_price)
  end
end
