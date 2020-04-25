class ReportsController < ApplicationController

	def agents
		request.format = 'csv' if params[:commit] == 'CSV'
		@colums = Report::colums(current_user)
		@users = policy_scope(User)
		@filter_users = @users
		@company = @filter_users.map{|a| [a.name_company,a.name_company]}.uniq
		@users =  IndexFilter::IndexServices.new(@users,params.dup).perform
		respond_to do |format|
			format.html{ @users = @users.decorate}
			format.csv{ send_data @users.to_csv(params[:colums]), filename: "users-#{Date.today}.csv" }
		end
	end

	def users_jobs
		@users = User.admin_and_user
	end


  def users_jobs_for_user
    @user = User.find_by_id (params[:user_id])
    @report = Report::users_job_actity(@user, params[:date_from],params[:date_to])
  end

end