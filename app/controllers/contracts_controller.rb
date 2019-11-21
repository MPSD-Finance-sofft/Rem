class ContractsController < ApplicationController

	def index
		@accords = policy_scope(Accord).state("contract").order(date_of_signature: :desc)
	    @accords =  IndexFilter::IndexServices.new(@accords,params).perform
	    @accords = @accords.decorate
	    respond_to do |format|
	      format.html
	      format.json
	  	end
	end
end

