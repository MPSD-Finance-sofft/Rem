class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.order(created_at: :desc).limit(5).decorate
    chart
  end

  def balance_price_calculation
  end


  private
  	def chart
  		if current_user.user_or_admin?
  			accord_data = Accord.all.select("created_at, month(created_at) as month, year(created_at) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		contract_data = Accord.state('contract').select("created_at, month(date_of_signature) as month, year(date_of_signature) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		terrain = Terrain.all.select("created_at, month(date_to_terrain) as month, year(date_to_terrain) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
        @chart = [{name: 'Vytvořené žádostí', data: accord_data }, {name: 'Podepsané smluvy', data: contract_data }, {name: 'Předáno do terénu', data: terrain}]
  		end
  	end
end
