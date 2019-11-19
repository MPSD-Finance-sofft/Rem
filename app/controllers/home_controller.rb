class HomeController < ApplicationController
  def index
    @users = User.all.where.not(id: current_user)
  end

  def balance_price_calculation
  end
end
