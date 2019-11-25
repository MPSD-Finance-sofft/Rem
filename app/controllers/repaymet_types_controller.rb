class RepaymetTypesController < ApplicationController
  before_action :set_repaymet_type, only: [:show, :edit, :update, :destroy]

  # GET /repaymet_types
  # GET /repaymet_types.json
  def index
    @repaymet_types = RepaymetType.all
  end

  # GET /repaymet_types/1
  # GET /repaymet_types/1.json
  def show
  end

  # GET /repaymet_types/new
  def new
    @repaymet_type = RepaymetType.new
  end

  # GET /repaymet_types/1/edit
  def edit
  end

  # POST /repaymet_types
  # POST /repaymet_types.json
  def create
    @repaymet_type = RepaymetType.new(repaymet_type_params)

    respond_to do |format|
      if @repaymet_type.save
        format.html { redirect_to @repaymet_type, notice: 'Repaymet type was successfully created.' }
        format.json { render :show, status: :created, location: @repaymet_type }
      else
        format.html { render :new }
        format.json { render json: @repaymet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repaymet_types/1
  # PATCH/PUT /repaymet_types/1.json
  def update
    respond_to do |format|
      if @repaymet_type.update(repaymet_type_params)
        format.html { redirect_to @repaymet_type, notice: 'Repaymet type was successfully updated.' }
        format.json { render :show, status: :ok, location: @repaymet_type }
      else
        format.html { render :edit }
        format.json { render json: @repaymet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repaymet_types/1
  # DELETE /repaymet_types/1.json
  def destroy
    @repaymet_type.destroy
    respond_to do |format|
      format.html { redirect_to repaymet_types_url, notice: 'Repaymet type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repaymet_type
      @repaymet_type = RepaymetType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repaymet_type_params
      params.require(:repaymet_type).permit(:description)
    end
end
