class ReportsController < ApplicationController

	def agents
		@colums = Report::colums
		@users = policy_scope(User)
		@filter_users = @users
		@company = @filter_users.map{|a| [a.name_company,a.name_company]}.uniq
		@users =  IndexFilter::IndexServices.new(@users,params.dup).perform.decorate
	end

end