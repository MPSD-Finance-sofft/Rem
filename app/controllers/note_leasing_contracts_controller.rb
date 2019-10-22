class NoteLeasingContractsController < ApplicationController
  before_action :set_note_leasing_contract, only: [:show, :edit, :update, :destroy]

  # GET /note_leasing_contracts
  # GET /note_leasing_contracts.json
  def index
    @note_leasing_contracts = NoteLeasingContract.all
  end

  # GET /note_leasing_contracts/1
  # GET /note_leasing_contracts/1.json
  def show
  end

  # GET /note_leasing_contracts/new
  def new
    @note_leasing_contract = NoteLeasingContract.new
  end

  # GET /note_leasing_contracts/1/edit
  def edit
  end

  # POST /note_leasing_contracts
  # POST /note_leasing_contracts.json
  def create
    @note_leasing_contract = NoteLeasingContract.new(note_leasing_contract_params)
    @note_leasing_contract.user_id = current_user.id
    respond_to do |format|
      if @note_leasing_contract.save
        format.html { redirect_to @note_leasing_contract.leasing_contract, notice: 'Note leasing contract was successfully created.' }
        format.json { render :show, status: :created, location: @note_leasing_contract }
      else
        format.html { render :new }
        format.json { render json: @note_leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_leasing_contracts/1
  # PATCH/PUT /note_leasing_contracts/1.json
  def update
    respond_to do |format|
      if @note_leasing_contract.update(note_leasing_contract_params)
        format.html { redirect_to @note_leasing_contract, notice: 'Note leasing contract was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_leasing_contract }
      else
        format.html { render :edit }
        format.json { render json: @note_leasing_contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_leasing_contracts/1
  # DELETE /note_leasing_contracts/1.json
  def destroy
    authorize @note_leasing_contract
    @leasing_contract = @note_leasing_contract.leasing_contract
    @note_leasing_contract.destroy
    respond_to do |format|
      format.html { redirect_to @leasing_contract, notice: 'Note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_leasing_contract
      @note_leasing_contract = NoteLeasingContract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_leasing_contract_params
      params.require(:note_leasing_contract).permit(:accord_id, :user_id, :description, :color, :permission)
    end
end
