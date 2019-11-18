class LeasingContractsController < ApplicationController
  before_action :set_leasing_contract, only: [:show, :edit, :update, :destroy ,:uploads, :create_uploads, :delete_image]

  # GET /leasing_contracts
  # GET /leasing_contracts.json
  def index
    authorize LeasingContract
    @leasing_contracts = policy_scope(LeasingContract).order(rent_from: :desc)
    @leasing_contracts.select(&:debt?).map{|a| a.state= "debt"; a.save}
    @leasing_contracts.select(&:active?).map{|a| a.state= "actions"; a.save}
    @leasing_contracts.select(&:added?).map{|a| a.state= "added"; a.save}
    template = LeasingContracts::IndexServices.new(params).perform
    @leasing_contracts =  IndexFilter::IndexServices.new(@leasing_contracts,params).perform
    @leasing_contracts = @leasing_contracts.decorate
    render template
  end

  # GET /leasing_contracts/1
  # GET /leasing_contracts/1.json
  def show  
    authorize @leasing_contract
    @repayments = @leasing_contract.calendar
    @leasing_constract_notes = NoteLeasingContractPolicy::Scope.new(@leasing_contract.id, current_user, NoteLeasingContract).resolve.decorate 
    Activity.create(user_id: current_user.id, what: "Nájemní smlouva číslo: #{@leasing_contract.id}", objet: "LeasingContract", object_id: @leasing_contract.id)
  end

  # GET /leasing_contracts/new
  def new
    @leasing_contract = LeasingContract.new.decorate
    @leasing_contract.accord_id = params[:accord_id]
  end

  # GET /leasing_contracts/1/edit
  def edit
    authorize @leasing_contract
  end

  # POST /leasing_contracts
  # POST /leasing_contracts.json
  def create
    @leasing_contract = LeasingContract.new(leasing_contract_params)
    respond_to do |format|
      if @leasing_contract.save
        format.html { redirect_to @leasing_contract, notice: 'Leasing contract was successfully created.' }
        format.json { render :show, status: :created, location: @leasing_contract }
      else
        format.html { render :new }
        format.json { render json: @leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leasing_contracts/1
  # PATCH/PUT /leasing_contracts/1.json
  def update
    respond_to do |format|
      if @leasing_contract.update(leasing_contract_params)
        format.html { redirect_to @leasing_contract, notice: 'Leasing contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @leasing_contract }
      else
        format.html { render :edit }
        format.json { render json: @leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leasing_contracts/1
  # DELETE /leasing_contracts/1.json
  def destroy
    @leasing_contract.destroy
    respond_to do |format|
      format.html { redirect_to leasing_contracts_url, notice: 'Leasing contract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def uploads
    authorize @leasing_contract
  end

  def create_uploads
    respond_to do |format|
      if @leasing_contract.update(leasing_contract_params)
        format.html { redirect_to uploads_leasing_contract_path(leasing_contract_id: @leasing_contract), notice: 'Přílohy přidány' }
        format.json { render :show, status: :ok, location: @leasing_contract }
      else
        format.html { render :edit }
        format.json { render json: @leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_image
    authorize @leasing_contract
    @file = ActiveStorage::Blob.find_signed(params[:file_id])
    @file.attachments.first.purge
    redirect_to uploads_leasing_contract_path(leasing_contract_id: @leasing_contract)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leasing_contract
      @leasing_contract = LeasingContract.find(params[:id]).decorate
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leasing_contract_params
      params.require(:leasing_contract).permit!
    end
end
