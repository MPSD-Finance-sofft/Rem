class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.order(created_at: :desc).limit(5).decorate
  end

  def balance_price_calculation
  end
end
