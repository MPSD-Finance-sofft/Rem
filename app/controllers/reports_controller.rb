class ReportsController < ApplicationController

	def agents
		@colums = Report::colums
		@users = User.select([@colums]).decorate
	end

end