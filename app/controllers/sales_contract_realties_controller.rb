class SalesContractRealtiesController < ApplicationController

  def destroy
    @sales_contract = SalesContract.find(params[:sales_contract_id])
    sales_contract_realty = @sales_contract.sales_contract_realty.find(params[:id])
    sales_contract_realty.destroy
    respond_to do |format|
      format.html { redirect_to sales_contract_path(@sales_contract), notice: 'Nemovitost odebrána ze smlouvy.' }
      format.json { head :no_content }
    end
  end


end
