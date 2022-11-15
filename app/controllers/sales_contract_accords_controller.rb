class SalesContractAccordsController < ApplicationController

  def new
    @sales_contract = SalesContract.find(params[:sales_contract_id])
    @accords = Accord.where(state: "contract").pluck([:contract_number, :id])
    @sales_contract_accord = SalesContractAccord.new
  end

  def create
    @sales_contract = SalesContract.find(params[:sales_contract_id])
    @accord = Accord.find(params[:accord_id])
    SalesContract.transaction do
      @sales_contract_accord = SalesContractAccord.new(sales_contract: @sales_contract, accord: @accord)
      @sales_contract.add_realty(@accord)
      @sales_contract_accord.save!
    end
    respond_to do |format|
      format.html { redirect_to sales_contract_path(@sales_contract), notice: 'Smlouva byla přiřazena k smlouvě.' }
      format.json { head :no_content }
    end
  end

  def destroy
    @sales_contract = SalesContract.find(params[:sales_contract_id])
    sales_contract_accord = @sales_contract.sales_contract_accords.find(params[:id])
    sales_contract_accord.destroy
    respond_to do |format|
      format.html { redirect_to sales_contract_path(@sales_contract), notice: 'Smlouva odebrána ze smlouvy.' }
      format.json { head :no_content }
    end
  end


end
