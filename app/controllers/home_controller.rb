class HomeController < ApplicationController
  def index
    @scheduler_logs = SchedulerLog.for_client.order(created_at: :desc).limit(5).decorate
    chart
  end

  def balance_price_calculation
  end


  private
  	def chart
  		if current_user.user_or_admin? || current_user.manager?
        accords = Accord.where(id: policy_scope(Accord).pluck(:id))
  			accord_data = accords.select("accords.created_at, month(accords.created_at) as month, year(accords.created_at) as year, count(accords.id) as count, accords.user_id, accords.agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		contract_data =  accords.where(state: 'contract').where("date_of_signature is not null").select("accords.created_at, month(date_of_signature) as month, year(date_of_signature) as year, count(id) as count, accords.user_id, accords.agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
    		terrain = Terrain.where(accord_id: accords.pluck(:id)).select("created_at, month(date_to_terrain) as month, year(date_to_terrain) as year, count(id) as count, user_id, agent_id").group(:month,:year).map{|a| [Date.new(a.year, a.month,1), a.count]}
        @chart = [{name: 'Vytvořené žádostí', data: accord_data }, {name: 'Podepsané smluvy', data: contract_data }, {name: 'Předáno do terénu', data: terrain}]
  		end
  	end
end
