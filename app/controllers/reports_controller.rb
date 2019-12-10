class ReportsController < ApplicationController

	def agents
		request.format = 'csv' if params[:commit] == 'CSV'
		@colums = Report::colums
		@users = policy_scope(User)
		@filter_users = @users
		@company = @filter_users.map{|a| [a.name_company,a.name_company]}.uniq
		@users =  IndexFilter::IndexServices.new(@users,params.dup).perform.decorate
		respond_to do |format|
			format.html
			format.csv { send_data User.to_csv(params[:colums]), filename: "users-#{Date.today}.csv" }
		end
	end

end