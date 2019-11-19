class HomeController < ApplicationController
  def index
  	session[:conversations] ||= []

    @users = User.all.where.not(id: current_user)
  end

  def balance_price_calculation
  end
end
