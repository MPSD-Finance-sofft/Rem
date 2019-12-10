class ReportsController < ApplicationController

	def agents
		@colums = Report::colums
		@users = User.all.decorate
	end

end