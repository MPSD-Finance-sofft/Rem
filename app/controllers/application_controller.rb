class ApplicationController < ActionController::Base
	before_action :authenticate_user!
	protect_from_forgery with: :exception
	before_action :set_paper_trail_whodunnit
end
