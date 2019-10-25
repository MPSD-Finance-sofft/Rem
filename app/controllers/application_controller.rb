class ApplicationController < ActionController::Base
	before_action :set_raven_context
	before_action :authenticate_user!
 	before_action :masquerade_user!
 	include Pundit
	protect_from_forgery with: :exception
	before_action :set_paper_trail_whodunnit
	before_action :current_user_can_sign_in?
	rescue_from Pundit::NotAuthorizedError , with: :deny_access

	def deny_access
		redirect_to root_path, alert: "Nemáte potřebná oprávnění"
	end

	def current_user_can_sign_in?
		unless current_user.nil? 
			unless User.find_by_username(current_user.username).try(:can_sign_in)
				sign_out current_user 
				redirect_to root_path, alert: "Nemáte potřebná oprávnění"
			end
		end
	end 
	def set_raven_context
    	Raven.user_context(id: session[:current_user_id]) # or anything else in session
    	Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  	end
end
