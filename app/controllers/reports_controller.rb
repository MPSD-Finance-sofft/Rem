class ReportsController < ApplicationController
  layout 'simple', only: :real_estate_agent_list

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
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
		@users = User.admin_and_user
	  Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled práce uživatelů", objet: "report_users_jobs")
  end


  def users_jobs_for_user
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    @user = User.find_by_id (params[:user_id])
    @report = Report::users_job_actity(@user, params[:date_from],params[:date_to])
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled práce uživatelů za uživatele", objet: "report_users_jobs_for_user")
  end

  def users_changes
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    @versions = PaperTrail::Version.where(item_type: "User").where(event: "update").order(created_at: :desc)
    @versions = @versions + PaperTrail::Version.where(item_type: "Address").where(item_id: Address.joins(:user_address).pluck("address_id")).where(event: "update").where(whodunnit: User.manager_and_agents_and_tipster.pluck(:id))
    @versions = @versions + PaperTrail::Version.where(item_type: "Mobile").where(item_id: Mobile.joins(:user_mobiles).pluck("mobile_id")).where(event: "update").where(whodunnit: User.manager_and_agents_and_tipster.pluck(:id))
    @versions = @versions + PaperTrail::Version.where(item_type: "Email").where(item_id: Email.joins(:user_emails).pluck("email_id")).where(event: "update").where(whodunnit: User.manager_and_agents_and_tipster.pluck(:id))
    @versions = @versions.sort_by(&:created_at).reverse
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled změn agentů od agentů", objet: "report_users_changes")
  end

  def leasing_contract
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled nájmeních smluv za období", objet: "report_leasing_contract")
  end

  def real_estate_agent_list
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" unless current_user.admin?
    @users = User.agents.includes(:ares).includes(:permission).includes(:email).order(can_sign_in: :desc).decorate
    Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled agentů s živnostní realitní zprostředkování", objet: "real_estate_agent_list")
  end

  def created_contracts_from_agents
     return redirect_to root_path, alert: "Nemáte potřebná oprávnění" if !current_user.user? && !current_user.admin?
     @users = User.agents.includes(:agent_accords, :permission).order(can_sign_in: :desc).decorate
     Activity.create(true_user_id: user_masquerade_owner.try(:id),user_id: current_user.id, what: "Přehled agentů počet navedených smluv a žádostí", objet: "created_contracts_from_agents")
  end

  def birthday
    return redirect_to root_path, alert: "Nemáte potřebná oprávnění" if !current_user.admin?
    @users = User.can_sign_in.manager_and_agents_and_tipster.order("extract(month from birthdate) ASC").order("extract(month from birthdate) ASC").decorate
  end
end
