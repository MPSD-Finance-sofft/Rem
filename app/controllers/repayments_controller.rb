class RepaymentsController < ApplicationController
  before_action :set_repayment, only: [:show, :edit, :update, :destroy]
  before_action :set_leasing_contract, only: [:show, :edit, :update, :destroy, :bulk_create, :delete_all_repayments]

  # GET /repayments
  # GET /repayments.json
  def index
    @repayments = Repayment.all
  end

  # GET /repayments/1
  # GET /repayments/1.json
  def show
  end

  # GET /repayments/new
  def new
    @repayment = Repayment.new
  end

  # GET /repayments/1/edit
  def edit
  end

  # POST /repayments
  # POST /repayments.json
  def create
    @repayment = Repayment.new(repayment_params)

    respond_to do |format|
      if @repayment.save
        format.html { redirect_to @repayment, notice: 'Repayment was successfully created.' }
        format.json { render :show, status: :created, location: @repayment }
      else
        format.html { render :new }
        format.json { render json: @repayment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def bulk_create
    @leasing_contract.generate_repayments
    respond_to do |format|
      if @leasing_contract.save
        format.html { redirect_to @leasing_contract, notice: 'Repayment was successfully created.' }
        format.json { render :show, status: :created, location: @leasing_contract }
      else
        format.html { render :new }
        format.json { render json: @leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

   def delete_all_repayments
      @leasing_contract.repayments.delete_all
      respond_to do |format|
        format.html { redirect_to leasing_contract_path(@leasing_contract), alert: 'Si v háji všechno sis smazals :P ' }
        format.json { render :show, status: :ok, location: @leasing_contract }
      end
  end

  # PATCH/PUT /repayments/1
  # PATCH/PUT /repayments/1.json
  def update
    respond_to do |format|
      if @repayment.update(repayment_params)
        format.html { redirect_to @repayment, notice: 'Repayment was successfully updated.' }
        format.json { render :show, status: :ok, location: @repayment }
      else
        format.html { render :edit }
        format.json { render json: @repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repayments/1
  # DELETE /repayments/1.json
  def destroy
    @repayment.destroy
    respond_to do |format|
      format.html { redirect_to repayments_url, notice: 'Repayment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repayment
      @repayment = Repayment.find(params[:id])
    end 

    def set_leasing_contract
      @leasing_contract = LeasingContract.find(params[:leasing_contract_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repayment_params
      params.require(:repayment).permit(:amount, :repayment_date, :leasing_contract_id)
    end
end
