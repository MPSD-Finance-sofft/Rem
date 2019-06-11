class RealtyTypesController < ApplicationController
  before_action :set_realty_type, only: [:show, :edit, :update, :destroy]

  # GET /realty_types
  # GET /realty_types.json
  def index
    @realty_types = RealtyType.all
  end

  # GET /realty_types/1
  # GET /realty_types/1.json
  def show
  end

  # GET /realty_types/new
  def new
    @realty_type = RealtyType.new
  end

  # GET /realty_types/1/edit
  def edit
  end

  # POST /realty_types
  # POST /realty_types.json
  def create
    @realty_type = RealtyType.new(realty_type_params)

    respond_to do |format|
      if @realty_type.save
        format.html { redirect_to @realty_type, notice: 'Realty type was successfully created.' }
        format.json { render :show, status: :created, location: @realty_type }
      else
        format.html { render :new }
        format.json { render json: @realty_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /realty_types/1
  # PATCH/PUT /realty_types/1.json
  def update
    respond_to do |format|
      if @realty_type.update(realty_type_params)
        format.html { redirect_to @realty_type, notice: 'Realty type was successfully updated.' }
        format.json { render :show, status: :ok, location: @realty_type }
      else
        format.html { render :edit }
        format.json { render json: @realty_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /realty_types/1
  # DELETE /realty_types/1.json
  def destroy
    @realty_type.destroy
    respond_to do |format|
      format.html { redirect_to realty_types_url, notice: 'Realty type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_realty_type
      @realty_type = RealtyType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def realty_type_params
      params.require(:realty_type).permit(:name)
    end
end
