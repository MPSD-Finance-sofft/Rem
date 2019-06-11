class CommitmentTypesController < ApplicationController
  before_action :set_commitment_type, only: [:show, :edit, :update, :destroy]

  # GET /commitment_types
  # GET /commitment_types.json
  def index
    @commitment_types = CommitmentType.all
  end

  # GET /commitment_types/1
  # GET /commitment_types/1.json
  def show
  end

  # GET /commitment_types/new
  def new
    @commitment_type = CommitmentType.new
  end

  # GET /commitment_types/1/edit
  def edit
  end

  # POST /commitment_types
  # POST /commitment_types.json
  def create
    @commitment_type = CommitmentType.new(commitment_type_params)

    respond_to do |format|
      if @commitment_type.save
        format.html { redirect_to @commitment_type, notice: 'Commitment type was successfully created.' }
        format.json { render :show, status: :created, location: @commitment_type }
      else
        format.html { render :new }
        format.json { render json: @commitment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commitment_types/1
  # PATCH/PUT /commitment_types/1.json
  def update
    respond_to do |format|
      if @commitment_type.update(commitment_type_params)
        format.html { redirect_to @commitment_type, notice: 'Commitment type was successfully updated.' }
        format.json { render :show, status: :ok, location: @commitment_type }
      else
        format.html { render :edit }
        format.json { render json: @commitment_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commitment_types/1
  # DELETE /commitment_types/1.json
  def destroy
    @commitment_type.destroy
    respond_to do |format|
      format.html { redirect_to commitment_types_url, notice: 'Commitment type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commitment_type
      @commitment_type = CommitmentType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commitment_type_params
      params.require(:commitment_type).permit(:description)
    end
end
