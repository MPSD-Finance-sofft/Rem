class MonthAdvencesController < ApplicationController

  def index
    @month_advance = MonthAdvence.joins(accord: :realty).order(date_of_payment: :desc).decorate
    @chart = MonthAdvence::chart_for_year
    Activity.create(true_user_id: user_masquerade_owner.try(:id), user_id: current_user.id, what: "Přehled svj", objet: "MonthAdvence")
  end

end
