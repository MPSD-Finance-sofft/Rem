class LeasingContractRealtiesController < ApplicationController
  before_action :set_leasing_contract_realty, only: [:show, :edit, :update, :destroy]

  # GET /leasing_contract_realties
  # GET /leasing_contract_realties.json
  def index
    @leasing_contract_realties = LeasingContractRealty.all
  end

  # GET /leasing_contract_realties/1
  # GET /leasing_contract_realties/1.json
  def show
  end

  # GET /leasing_contract_realties/new
  def new
    @leasing_contract_realty = LeasingContractRealty.new
  end

  # GET /leasing_contract_realties/1/edit
  def edit
  end

  # POST /leasing_contract_realties
  # POST /leasing_contract_realties.json
  def create
    @leasing_contract_realty = LeasingContractRealty.new(leasing_contract_realty_params)

    respond_to do |format|
      if @leasing_contract_realty.save
        format.html { redirect_to @leasing_contract_realty, notice: 'Leasing contract realty was successfully created.' }
        format.json { render :show, status: :created, location: @leasing_contract_realty }
      else
        format.html { render :new }
        format.json { render json: @leasing_contract_realty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leasing_contract_realties/1
  # PATCH/PUT /leasing_contract_realties/1.json
  def update
    respond_to do |format|
      if @leasing_contract_realty.update(leasing_contract_realty_params)
        format.html { redirect_to @leasing_contract_realty, notice: 'Leasing contract realty was successfully updated.' }
        format.json { render :show, status: :ok, location: @leasing_contract_realty }
      else
        format.html { render :edit }
        format.json { render json: @leasing_contract_realty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leasing_contract_realties/1
  # DELETE /leasing_contract_realties/1.json
  def destroy
    @leasing_contract_realty.destroy
    respond_to do |format|
      format.html { redirect_to leasing_contract_realties_url, notice: 'Leasing contract realty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leasing_contract_realty
      @leasing_contract_realty = LeasingContractRealty.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leasing_contract_realty_params
      params.require(:leasing_contract_realty).permit(:leasing_contract_id, :realty_id)
    end
end
