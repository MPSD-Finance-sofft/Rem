class SalesContractsController < ApplicationController
  before_action :set_sales_contract, only: [:show, :edit, :update, :destroy]

  # GET /sales_contracts
  # GET /sales_contracts.json
  def index
    authorize SalesContract
    @sales_contracts = SalesContract.order(:date_of_sale_realty).decorate
  end

  # GET /sales_contracts/1
  # GET /sales_contracts/1.json
  def show
    authorize @sales_contract
    Activity.create(true_user_id: user_masquerade_owner.try(:id), user_id: current_user.id, what: "Smlouva o prodeji číslo: #{@sales_contract.id}", objet: "SalesContract", object_id: @sales_contract.id)
  end

  # GET /sales_contracts/new
  def new
    @sales_contract = SalesContract.new.decorate
    @sales_contract.accord_id = params[:accord_id]
  end

  # GET /sales_contracts/1/edit
  def edit
    authorize @sales_contract
    @sales_contract = @sales_contract.decorate
  end

  # POST /sales_contracts
  # POST /sales_contracts.json
  def create
    @sales_contract = SalesContract.new(sales_contract_params)
    @sales_contract.user = current_user
    respond_to do |format|
      if @sales_contract.save
        format.html { redirect_to @sales_contract, notice: 'Sales contract was successfully created.' }
        format.json { render :show, status: :created, location: @sales_contract }
      else
        format.html { render :new }
        format.json { render json: @sales_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales_contracts/1
  # PATCH/PUT /sales_contracts/1.json
  def update
    respond_to do |format|
      if @sales_contract.update(sales_contract_params)
        format.html { redirect_to @sales_contract, notice: 'Sales contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @sales_contract }
      else
        format.html { render :edit }
        format.json { render json: @sales_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales_contracts/1
  # DELETE /sales_contracts/1.json
  def destroy
    @sales_contract.destroy
    respond_to do |format|
      format.html { redirect_to sales_contracts_url, notice: 'Sales contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sales_contract
      @sales_contract = SalesContract.find(params[:id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sales_contract_params
      params.require(:sales_contract).permit(:accord_id, :date_of_sale_realty, :amount, :date_of_receipt_of_payment, :user_id, :sate, :kind)
    end
end
