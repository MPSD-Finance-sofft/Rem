class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.all.decorate
  end

  def balance_price_calculation
  end
end
