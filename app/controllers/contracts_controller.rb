class ContractsController < ApplicationController

	def index
		@accords = Accord.state("contract").order(contract_number: :desc)
		authorize @accords, policy_class: ContractPolicy 
	    @accords =  IndexFilter::IndexServices.new(@accords,params).perform
	    @accords = @accords.decorate
	    respond_to do |format|
	      format.html
	      format.json
	  	end
	end
end

