class ContractsController < ApplicationController

	def index
		@accords = Accord.all
		authorize @accords, policy_class: ContractPolicy 
	    @accords =  Accords::IndexServices.new(@accords,params).perform
	    @accords = @accords.decorate
	    respond_to do |format|
	      format.html
	      format.json
	  	end
	end
end

