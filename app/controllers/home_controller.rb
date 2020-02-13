class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.order(created_at: :desc).limit(5).decorate
    chart
  end

  def balance_price_calculation
  end


  private
  	def chart
  		if current_user.admin?
  			accord_data = Accord.all.select("created_at, month(created_at) as month, year(created_at) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		contract_data = Accord.state('contract').select("created_at, month(date_of_signature) as month, year(date_of_signature) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		@chart = [{name: 'počet žádostí', data: accord_data }, {name: 'počet smluv', data: contract_data }]
  		end
  	end
end
