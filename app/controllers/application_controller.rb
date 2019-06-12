class ApplicationController < ActionController::Base
	before_action :authenticate_user!
 	before_action :masquerade_user!
 	include Pundit
	protect_from_forgery with: :exception
	before_action :set_paper_trail_whodunnit

	rescue_from Pundit::NotAuthorizedError , with: :deny_access

	def deny_access
		redirect_to root_path, alert: "Nemáte potřebná oprávnění"
	end
end
