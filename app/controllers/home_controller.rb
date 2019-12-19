class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.decorate
  end

  def balance_price_calculation
  end
end
