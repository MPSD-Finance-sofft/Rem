class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.order(created_at: :desc).limit(5).decorate
    @accords = Accord.all.select("created_at, month(created_at) as month, year(created_at) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]} if current_user.admin?
  end

  def balance_price_calculation
  end
end
