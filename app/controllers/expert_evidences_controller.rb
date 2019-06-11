class ExpertEvidencesController < ApplicationController
  before_action :set_expert_evidence, only: [:show, :edit, :update, :destroy]

  # GET /expert_evidences
  # GET /expert_evidences.json
  def index
    @expert_evidences = ExpertEvidence.all
  end

  # GET /expert_evidences/1
  # GET /expert_evidences/1.json
  def show
  end

  # GET /expert_evidences/new
  def new
    @expert_evidence = ExpertEvidence.new
  end

  # GET /expert_evidences/1/edit
  def edit
  end

  # POST /expert_evidences
  # POST /expert_evidences.json
  def create
    @expert_evidence = ExpertEvidence.new(expert_evidence_params)

    respond_to do |format|
      if @expert_evidence.save
        format.html { redirect_to @expert_evidence, notice: 'Expert evidence was successfully created.' }
        format.json { render :show, status: :created, location: @expert_evidence }
      else
        format.html { render :new }
        format.json { render json: @expert_evidence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expert_evidences/1
  # PATCH/PUT /expert_evidences/1.json
  def update
    respond_to do |format|
      if @expert_evidence.update(expert_evidence_params)
        format.html { redirect_to @expert_evidence, notice: 'Expert evidence was successfully updated.' }
        format.json { render :show, status: :ok, location: @expert_evidence }
      else
        format.html { render :edit }
        format.json { render json: @expert_evidence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expert_evidences/1
  # DELETE /expert_evidences/1.json
  def destroy
    @expert_evidence.destroy
    respond_to do |format|
      format.html { redirect_to expert_evidences_url, notice: 'Expert evidence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expert_evidence
      @expert_evidence = ExpertEvidence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expert_evidence_params
      params.require(:expert_evidence).permit(:of_date, :number, :user_id, :price, :market_price, :accord_id)
    end
end
