class AccordsController < ApplicationController
  before_action :set_accord, only: [:show, :edit, :update, :destroy, :changes, :uploads, :create_uploads, :delete_image]

  # GET /accords
  # GET /accords.json
  def index
    @accords = policy_scope(Accord).order(created_at: :desc)
    @accords =  Accords::IndexServices.new(@accords,params).perform
    @accords = @accords.decorate
    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /accords/1
  # GET /accords/1.json
  def show
    authorize @accord
    @notes = NotePolicy::Scope.new(@accord.id, current_user, Note).resolve.decorate
    @expert_evidences = ExpertEvidencePolicy::Scope.new(@accord.id, current_user, ExpertEvidence).resolve.decorate
    @commitments = CommitmentPolicy::Scope.new(@accord.id, current_user, Commitment).resolve.decorate
    @expenses = ExpensePolicy::Scope.new(@accord.id, current_user, Expense).resolve.decorate
    @energies = EnergyPolicy::Scope.new(@accord.id, current_user, Energy).resolve.decorate
    @electricity = EnergyPolicy::Scope.new(@accord.id, current_user, Eletricity).resolve.decorate
    @gas = EnergyPolicy::Scope.new(@accord.id, current_user, GasEnergy).resolve.decorate
    @water = EnergyPolicy::Scope.new(@accord.id, current_user, WaterEnergy).resolve.decorate
    @tax_returns = TaxReturnPolicy::Scope.new(@accord.id, current_user, TaxReturn).resolve.decorate
    @insurance = InsurancePolicy::Scope.new(@accord.id, current_user, Insurance).resolve.decorate
    @leasing_contracts = LeasingContract.for_accord(@accord.id).pluck(:id)
  end

  # GET /accords/new
  def new
    @accord = Accord.new.decorate
    @accord.current_user = current_user
  end

  # GET /accords/1/edit
  def edit  
    authorize @accord
  end

  # POST /accords
  # POST /accords.json
  def create
    @accord = Accord.new(accord_params).decorate
    @accord.current_user = current_user
    @accord.creator = current_user
    @accord.state = Accord.states[:state_new]
    respond_to do |format|
      if @accord.save
        format.html { redirect_to @accord, notice: 'Accord was successfully created.' }
        format.json { render :show, status: :created, location: @accord }
      else
        format.html { render :new }
        format.json { render json: @accord.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accords/1
  # PATCH/PUT /accords/1.json
  def update
    authorize @accord
    respond_to do |format|
      if @accord.update(accord_params)
        format.html { redirect_to @accord, notice: 'Accord was successfully updated.' }
        format.json { render :show, status: :ok, location: @accord }
      else
        format.html { render :edit }
        format.json { render json: @accord.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accords/1
  # DELETE /accords/1.json
  def destroy
    authorize @accord
    @accord.destroy
    respond_to do |format|
      format.html { redirect_to accords_url, notice: 'Accord was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def changes
    authorize @accord
  end

  def uploads
    authorize @accord
  end

  def create_uploads
    respond_to do |format|
      if @accord.update(accord_params)
        format.html { redirect_to uploads_accord_path(accord_id: @accord), notice: 'Přílohy přidány' }
        format.json { render :show, status: :ok, location: @accord }
      else
        format.html { render :edit }
        format.json { render json: @accord.errors, status: :unprocessable_entity }
      end
    end
  end

  def delete_image
    authorize @accord
    @file = ActiveStorage::Blob.find_signed(params[:file_id])
    @file.attachments.first.purge
    redirect_to uploads_accord_path(accord_id: @accord)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accord
      @accord = Accord.find(params[:id]).decorate
      @accord.current_user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accord_params
       params.require(:accord).permit!
    end
end
